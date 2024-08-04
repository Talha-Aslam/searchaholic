import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_project/data.dart';

import 'package:quickalert/quickalert.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _isObscure = true;
  var email = TextEditingController();
  var password = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  double height = 0, width = 0;

  void onClickFun(RoundedLoadingButtonController btnController) async {
    Timer(const Duration(seconds: 3), () {
      _btnController.success();
    });
  }

  // ignore: unused_element
  Future<void> _signOut() async {
    Navigator.pop(context);
  }

  void onClickFun2(RoundedLoadingButtonController btnController) async {
    Timer(const Duration(seconds: 2), () {
      _btnController.error();
      Future.delayed(const Duration(seconds: 1));
      _btnController.reset();
    });
  }

  void myalert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Login Faild',
      text: 'Wrong Email or Password',
    );
  }

  void myalert1() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Login Successful',
      text: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: appData.isLoggedIn
            ? Column(
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
                    padding: EdgeInsets.only(top: 300.0, left: 30),
                    child: Text(
                      'You are Already Logged In! Please Logout to Continue',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 70),
                    child: ElevatedButton(
                      child: const Text('Logout'),
                      onPressed: () {
                        // _signOut();
                        // setState(() {
                        //   appData.isLoggedIn = false;
                        // });
                        setState(() {
                          appData.isLoggedIn = false;
                          appData.Email = "You are not logged in";
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                    ),
                  ),
                ],
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                    key: formkey,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: height * .3,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                image: DecorationImage(
                                  image: AssetImage('images/plants2.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 27),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Icon(
                                                Icons.arrow_back_ios_new_sharp,
                                                size: 25,
                                                color: Colors.white)),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Icon(Icons.more_horiz,
                                              size: 25, color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                              ),
                              child: Container(
                                  height: height * .7,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50)))),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 300.0, left: 40),
                          child: Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.027,
                            ),
                            width: MediaQuery.of(context).size.width * 0.82,
                            child: PhysicalModel(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              //elevation: 7.0,
                              //shadowColor: Colors.grey,
                              child: TextFormField(
                                controller: email,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    size: 20,
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[450],
                                    fontWeight: FontWeight.w500,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        width: 0.15, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 390.0, left: 40),
                          child: Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.015,
                            ),
                            width: MediaQuery.of(context).size.width * 0.82,
                            child: PhysicalModel(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              // elevation: 7.0,
                              //shadowColor: Colors.grey,
                              child: TextFormField(
                                obscureText: _isObscure,

                                // validation
                                controller: password,
                                validator: MultiValidator(
                                  [
                                    RequiredValidator(
                                        errorText: 'Password Required'),
                                  ],
                                ).call,

                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    size: 20,
                                  ),
                                  suffixIcon: IconButton(
                                      icon: Icon(_isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      }),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[450],
                                    fontWeight: FontWeight.w500,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    //borderSide: const BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // 5. Login Button
                        Padding(
                          padding: const EdgeInsets.only(top: 500.0, left: 85),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              height: 50,
                              child: PhysicalModel(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                                //elevation: 8.0,
                                // shadowColor: Colors.blue,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              )),
                        ),

                        //dont have account
                        Padding(
                          padding: const EdgeInsets.only(top: 580.0, left: 20),
                          child: Container(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                  text: "Don't have an account?",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: " SignUp!",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          color:
                                              Color.fromRGBO(53, 108, 254, 1)),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // ignore: avoid_print
                                          print("SignUp");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AlertDialog(
                                                      title: Text(
                                                          "registraton under construction high ALert dont ask questions on this (*.*)"),
                                                    )),
                                          );
                                        },
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        //logo of searchaholic
                        const Padding(
                          padding: EdgeInsets.only(top: 230.0, left: 04),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    image: AssetImage("images/logo4.png"),
                                    width: 170),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom))
                      ],
                    )),
              ));
  }
}
