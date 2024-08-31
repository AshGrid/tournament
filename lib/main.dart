import 'package:flutter/material.dart';
import 'package:untitled/screens/bottom_sheet.dart';
import 'package:untitled/screens/match_details.dart';
import 'package:untitled/screens/matches_screen.dart';
import 'package:untitled/screens/home_screen.dart';
import 'package:untitled/screens/login.dart';
import 'package:untitled/screens/more_screen.dart';
import 'package:untitled/screens/profile_screen.dart';
import 'package:untitled/screens/splash_screen.dart';

import 'components/bottom_navigation.dart';
import 'components/colors.dart';
import 'components/custom_appbar.dart';
import '../models/match.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  Match? selectedMatch; // To store the selected match

  // Callback to handle bottom navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      selectedMatch = null; // Reset selected match when switching tabs
    });
  }

  // Callback to handle match selection
  void _onMatchSelected(Match match) {
    setState(() {
      selectedMatch = match; // Store the selected match
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        // Applying gradient background
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundColor, // Ensure this is defined in your colors.dart
        ),
        child: selectedMatch == null
            ? _getPage(_selectedIndex)
            : MatchDetailsPage(match: selectedMatch!), // Show MatchDetailsPage if a match is selected
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _getPage(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return MatchesScreen(onMatchTap: _onMatchSelected); // Pass the callback to handle match selection
      case 2:
        return MoreScreen();
      default:
        return Container();
    }
  }
}
