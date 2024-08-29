import 'package:flutter/material.dart';
import 'package:untitled/screens/bottom_sheet.dart';
import 'package:untitled/screens/matches_screen.dart';
import 'package:untitled/screens/home_screen.dart';
import 'package:untitled/screens/login.dart';
import 'package:untitled/screens/more_screen.dart';
import 'package:untitled/screens/profile_screen.dart';
import 'package:untitled/screens/splash_screen.dart';

import 'components/bottom_navigation.dart';
import 'components/colors.dart';
import 'components/custom_appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  SplashScreen(),

    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({super.key});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: _getPage(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      backgroundColor: AppColors.backgroundColor,
    );
  }

  Widget _getPage(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return MatchesScreen();
      case 2:
        return MoreScreen();
      default:
        return Container();
    }
  }
}
