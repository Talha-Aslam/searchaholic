import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_project/card.dart';
import 'package:my_project/navbar.dart';
import 'dummy_data.dart'; // Import the dummy data

class Search extends StatefulWidget {
  const Search({super.key});
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // Initializing data vars
  String fullAddress = ".....";
  final TextEditingController _searchQuery = TextEditingController();
  TextEditingController txt = TextEditingController();
  List allProducts = [];
  List nearbyProducts = [];
  List searchedProducts = [];
  late double userlat;
  late double userlon;
  bool status1 = false;

  int status = 0;
  // This will store the unique key for the scaffold widget
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  // This will initialize when the class is being called, initialize the current scaffold key, initialize all the products and location
  void initState() {
    super.initState();
    // Store current scaffold widget key
    _scaffoldKey = GlobalKey<ScaffoldState>();
    setProducts();
  }

  @override
  Widget build(BuildContext context) {
    // This widget refreshes and updates the child widget by pull refresh method
    return RefreshIndicator(
      onRefresh: () async {
        await setProducts();
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const Navbar(),
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),
          ),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          child: const Icon(
                            Icons.menu_open_sharp,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: PopupMenuButton(
                          icon: const Icon(
                            Icons.more_horiz,
                            size: 25,
                            color: Colors.white,
                          ),
                          itemBuilder: (context) => [],
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 220.0),
                  child: Text(
                    'Search for',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 150.0),
                  child: Text(
                    'Your Medicine!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 26,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: TextField(
                    controller: _searchQuery,
                    onSubmitted: (value) {},
                    onChanged: (value) {
                      // Filtering the Products
                      setState(() {
                        if (value == "" && status == 0) {
                          searchedProducts = allProducts;
                        }
                        if (value != "" && status == 0) {
                          searchedProducts = allProducts
                              .where((element) => element["Name"]
                                  .toString()
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        }
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.filter_list_off_outlined),
                        onPressed: () {},
                      ),
                      hintText: "Search",
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 235.0, left: 35),
            child: Text(
              "Search Results",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 269.0, left: 30),
            child: SizedBox(
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.black,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    fullAddress,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 85, left: 280),
            child: CircleAvatar(
              maxRadius: 25,
              minRadius: 25,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("images/man.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 280.0),
            child: ListView.builder(
              itemCount:
                  status == 0 ? searchedProducts.length : nearbyProducts.length,
              itemBuilder: (context, index) {
                if (status == 0) {
                  return CardView(
                    productList: searchedProducts[index],
                  );
                } else {
                  return CardView(
                    productList: nearbyProducts[index],
                  );
                }
              },
            ),
          ),
        ]),
      ),
    );
  }

  // This sets the list of all the products
  Future<void> setProducts() async {
    // Using dummy data
    var products = DummyData.products;
    setState(() {
      allProducts = products;
      searchedProducts = products;
    });
  }

  // Search Query for Products
  Future<void> searchQuery(int index) async {
    setState(() {
      status = index;
    });

    if (index == 0) return;

    // nearbyProducts
    var pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    int radius = 5000000;
    nearbyProducts.clear();
    // Filter the products based on the location
    for (var element in allProducts) {
      if (element["Latitude"] != null && element["Longitude"] != null) {
        var distance = Geolocator.distanceBetween(
          pos.latitude,
          pos.longitude,
          element["Latitude"],
          element["Longitude"],
        );
        if (distance / 1000 < radius) {
          nearbyProducts.add(element);
        }
      }
    }
  }
}
