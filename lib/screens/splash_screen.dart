import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled/components/colors.dart';
import 'myhomePage.dart'; // Import your main screen here

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the main screen after 7 seconds
    Timer(Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()), // Replace with your main screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isTablet?AppColors.backgroundColor:AppColors.backgroundTransparent,
        ),
        child: Center(
          child: Image.asset(
            'assets/images/soccer.gif', // Replace with your image asset path
            fit: BoxFit.cover, // Ensures the GIF covers the entire screen
            height: isTablet ? MediaQuery.of(context).size.height*0.8 : MediaQuery.of(context).size.height, // Full screen height
            width: isTablet ? MediaQuery.of(context).size.height*0.7: MediaQuery.of(context).size.width,  // Full screen width
          ),
        ),
      ),
    );
  }
}
