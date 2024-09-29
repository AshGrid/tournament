import 'package:flutter/material.dart';
import 'package:untitled/screens/fantasy_screen.dart';
import 'package:untitled/screens/match_details.dart';
import 'package:untitled/screens/matches_screen.dart';
import 'package:untitled/screens/home_screen.dart';
import 'package:untitled/screens/fovorite_screen.dart';
import 'package:untitled/screens/profile_screen.dart';
import 'package:untitled/screens/splash_screen.dart';
import 'package:untitled/screens/trophy_screen.dart';

import '../components/bottom_navigation.dart';
import '../components/colors.dart';
import '../components/custom_appbar.dart';
import '../models/league.dart';
import 'LeagueDetailsScreen.dart';
import 'menu_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool _showTrophyScreen = false;
  String? _selectedTrophyName;
  League? _selectedLeague;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _showTrophyScreen = false; // Reset trophy screen when switching tabs
      _selectedLeague = null; // Reset league when navigating through the navbar
    });
  }

  void _onTrophySelected(String trophyName) {
    setState(() {
      _showTrophyScreen = true;
      _selectedTrophyName = trophyName;
      _selectedLeague = null; // Reset league when selecting a new trophy
    });
  }

  void _onLeagueSelected(League league) {
    setState(() {
      _selectedLeague = league; // Update with the selected league
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nav,
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width > 600
            ? MediaQuery.of(context).size.width * 0.6
            : MediaQuery.of(context).size.width * 0.8,
        child: ProfileScreen(),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundColor,
        ),
        child: ClipRRect(
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                CustomAppBar(onTrophySelected: _onTrophySelected),
              ];
            },
            body: _getPage(_selectedIndex),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 84,
        decoration: BoxDecoration(
          color: AppColors.nav,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: AppColors.navbarShadow,
              spreadRadius: 4,
              blurRadius: 5.9,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: BottomNavigation(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  Widget _getPage(int selectedIndex) {
    // Show league details if a league is selected
    if (_selectedLeague != null) {
      return LeagueDetailsScreen(league: _selectedLeague!);
    }

    // Show trophy screen if a trophy is selected
    if (_showTrophyScreen && _selectedTrophyName != null) {
      return TrophyScreen(
        trophyName: _selectedTrophyName!,
        onLeagueSelected: _onLeagueSelected, // Pass the callback to TrophyScreen
      );
    }

    // Return the selected index page
    switch (selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const MatchesScreen();
      case 2:
        return  FavoriteScreen();
      case 3:
        return  FantasyScreen();
      case 4:
        return  MenuScreen();
      default:
        return const SizedBox();
    }
  }
}
