import "package:flutter/material.dart";

// Card View Class
//This class show the details of the products from the database using database
class CardView extends StatelessWidget {
  const CardView({
    super.key,
    required this.productList,
  });
  final Map<String, dynamic> productList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      height: 100,
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, 3))
          ]),
      child: Row(
        children: [
          const Padding(
              padding: EdgeInsets.only(top: 07.0, left: 20),
              child: CircleAvatar(
                  maxRadius: 22,
                  minRadius: 22,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("images/box.png"))),
          const Padding(padding: EdgeInsets.only(left: 12.0)),
          const SizedBox(width: 10),

          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    "${productList['Name']}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('Rs. ${productList["Price"]}',
                    style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.normal,
                        fontSize: 15)),
                const SizedBox(height: 5),
                Text('In Stock: ${productList["Quantity"]}',
                    style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.normal,
                        fontSize: 16)),
                const SizedBox(height: 5),
                Text('${productList["StoreName"]}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16)),
              ],
            ),
          ),

          // Tap Button with forward icon for Product Description, blue color with
          //this show the product detail description
          Expanded(
            flex: 1,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
              child: ButtonTheme(
                height: 50,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const CircleBorder()),
                    child: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
