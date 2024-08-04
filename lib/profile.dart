//import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter/material.dart';
import 'package:my_project/data.dart';
import 'package:my_project/login_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double height = 0, width = 0;
  // ignore: non_constant_identifier_names
  dynamic Name;
  // ignore: non_constant_identifier_names
  dynamic Email;
  // ignore: non_constant_identifier_names
  dynamic Phone_number;

  Future getprofile() async {
    // Getting Documents from Firestore
    if (appData.Email != "You are not logged in") {
      // ignore: prefer_typing_uninitialized_variables
      var data;
      var data1 = data.document(appData.Email);
      var data2 = await data1.get();

      setState(() {
        Name = data2['name'];
        Email = data2['email'];
        Phone_number = data2['phNo'];

        //password = data2['password'];
      });
    }
  }

  @override
// Update State
  void initState() {
    getprofile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: appData.isLoggedIn
          ? Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: height * .31,
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 27),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Icon(Icons.arrow_back_ios_new_sharp,
                                        size: 25, color: Colors.white)),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Text(
                                  'My Profile',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 26),
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Icon(Icons.more_horiz,
                                      size: 25, color: Colors.white)),
                            ],
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Container(
                          height: height * .6,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 100.0, left: 50),
                  child: CircleAvatar(
                    maxRadius: 50,
                    minRadius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("images/man.png"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 130.0, left: 160),
                  child: Text(
                    '$Name',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 300.0, left: 30),
                  child: Text(
                    'Details',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 340.0, left: 02),
                    child: Divider(
                      thickness: 2.0,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 370.0, left: 30),
                  child: Text(
                    'Email',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 410.0, left: 30),
                  child: Text(
                    '$Email',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 22),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 450.0, left: 02),
                    child: Divider(
                      thickness: 2.0,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 480.0, left: 30),
                  child: Text(
                    'Phone Number',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 520.0, left: 30),
                  child: Text(
                    '$Phone_number',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 660, left: 135.0),
                  child: FloatingActionButton.extended(
                    icon: const Icon(Icons.logout_outlined),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    label: const Text("Logout"),
                    onPressed: () {
                      // _signOut();
                      // setState(() {
                      //   appData.isLoggedIn = false;
                      // });
                      setState(() {
                        appData.isLoggedIn = false;
                        appData.Email = "You are not logged in";
                      });
                    },
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom))
              ],
            )
          : Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                      padding: EdgeInsets.only(top: 60.0, right: 260),
                      child: Icon(Icons.arrow_back_ios_new_sharp,
                          size: 25, color: Colors.black)),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 300.0, left: 50),
                  child: Text(
                    'You are not logged in! Please Log In to Continue',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 80),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
