import 'package:flutter/material.dart';
import 'package:untitled/screens/match_details.dart';
import 'package:untitled/screens/matches_screen.dart';
import 'package:untitled/screens/home_screen.dart';
import 'package:untitled/screens/fovorite_screen.dart';
import 'package:untitled/screens/profile_screen.dart';
import 'package:untitled/screens/splash_screen.dart';
import 'package:untitled/screens/trophy_screen.dart';
import 'components/bottom_navigation.dart';
import 'components/colors.dart';
import 'components/custom_appbar.dart';
import '../models/Match.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Oswald'),
          bodyMedium: TextStyle(fontFamily: 'Oswald'),
          bodySmall: TextStyle(fontFamily: 'Oswald'),
          // Add other text styles if needed
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  SplashScreen(),
    );
  }
}
 // Import your TrophyScreen


