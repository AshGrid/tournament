import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled/components/colors.dart';
import '../main.dart';
import 'login.dart';
import 'myhomePage.dart';
 // Import your main screen here

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the main screen after 5 seconds
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()), // Replace with your main screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashScreen, // Set your desired background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace with your logo or splash screen content
            Image.asset(
              'assets/images/soccer.gif', // Replace with your image asset path
              height: 150.0,
            ),
            SizedBox(height: 20),
            Text(
              'ABC Events',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
