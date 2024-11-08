import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_project/search_screen.dart';
// import 'package:my_project/search_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  // this will initialze this (navigatetohome function whenever this is class is being called)
  void initState() {
    super.initState();
    navigateToHome();
  }

// this is a function that will navigate to home screen after some random time delay
  navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 5000)).then((value) => {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Search(),
              ))
        });
  }

  @override
  //loading screen
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Search A holic logo
            Image(image: AssetImage("images/logo3.png"), width: 240),
            SizedBox(height: 35),
            //loading animation
            SpinKitChasingDots(
              color: Colors.black,
              size: 40.0,
            )
          ],
        ),
      ),
    );
  }
}
