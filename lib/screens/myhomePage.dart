import 'package:flutter/material.dart';
import 'package:untitled/models/Club.dart';
import 'package:untitled/models/Team.dart';
import 'package:untitled/models/News.dart';
import 'package:untitled/models/Player.dart';
import 'package:untitled/models/Trophy.dart';
import 'package:untitled/screens/PlayerDetails.dart';
import 'package:untitled/screens/fantasy_screen.dart';
import 'package:untitled/screens/match_details.dart';
import 'package:untitled/screens/matches_screen.dart';
import 'package:untitled/screens/home_screen.dart';
import 'package:untitled/screens/fovorite_screen.dart';
import 'package:untitled/screens/notificationScreen.dart';
import 'package:untitled/screens/profile_screen.dart';
import 'package:untitled/screens/splash_screen.dart';
import 'package:untitled/screens/teamPage.dart';
import 'package:untitled/screens/trophy_screen.dart';

import '../Service/data_service.dart';
import '../components/bottom_navigation.dart';
import '../components/colors.dart';
import '../components/custom_appbar.dart';
import '../models/Notif.dart';
import '../models/League.dart';
import '../models/Match.dart';
import 'LeagueDetailsScreen.dart';
import 'menu_screen.dart';
import 'newsDetails.dart';

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
  News? _selectedNewsItem;
  bool _notifPressed = false;
  Match? _selectedMatch;
  Club? _selectedTeam;
  Player? _selectedPlayer;



  final List<Notif> mockNotifications = [
    Notif(
      title: " Matches cette semaine pour une compétition",
      description: "Cette semaine, ne manquez pas les rencontres de la [Nom de la Compétition]. De grands moments de football vous attendent !",
      image: "assets/images/monoprix.jpg",

    ),
    Notif(
      title: "Matches demain pour une compétition",
      description: "Préparez-vous pour demain ! Les matches de la [Nom de la Compétition] approchent à grands pas.",
      image: "assets/images/monoprix.jpg",

    ),
    Notif(
      title: " Club préféré a marqué un but",
      description: "Goooal pour [Nom du Club] ! Votre équipe favorite prend l’avantage. Continuez à suivre le match ! .",
      image: "assets/images/monoprix.jpg",

    ),

  ];




  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _showTrophyScreen = false; // Reset trophy screen when switching tabs
      _selectedLeague = null; // Reset league when navigating through the navbar
      _selectedNewsItem = null;
      _selectedMatch = null;
      _selectedTeam = null;
      _selectedPlayer = null;
      _notifPressed = false;
    });
  }

  void _onTrophySelected(String trophyName) {
    setState(() {
      _showTrophyScreen = true;
      _selectedTrophyName = trophyName;
      _selectedLeague = null; // Reset league when selecting a new trophy
      _selectedNewsItem = null;
      _selectedMatch = null;
      _selectedTeam = null;
      _notifPressed = false;
      _selectedPlayer = null;
    });
  }

  void _onNotifPressed() {
    setState(() {
      _showTrophyScreen = false;
      _selectedLeague = null; // Reset league when selecting a new trophy
      _selectedNewsItem = null;
      _selectedMatch = null;
      _selectedTeam = null;
      _notifPressed = true;
      _selectedPlayer = null;
    });
  }

  void _onLeagueSelected(League league) {
    setState(() {
      _selectedLeague = league; // Update with the selected league
      _selectedNewsItem = null;
      _selectedMatch = null;
      _selectedTeam = null;
      _notifPressed = false;
      _selectedPlayer = null;
    });
  }

  void _onNewsItemSelected(News news) {
    setState(() {
      _selectedNewsItem = news; // Update with the selected league
    });
  }
  void _onMatchItemSelected(Match match) {
    setState(() {
      _selectedMatch = match; // Update with the selected league
    });
  }

  void _onTeamItemSelected(Club team) {
    setState(() {
      _selectedTeam = team;
      _selectedMatch = null;
      _selectedPlayer = null;
    });
  }
  void _onPlayerSelected(Player player) {
    setState(() {
      _selectedTeam = null;
      _selectedMatch = null;
      _selectedPlayer = player;
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
                CustomAppBar(onTrophySelected: _onTrophySelected, onNotifPressed: _onNotifPressed,),
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
      return LeagueDetailsScreen(league: _selectedLeague!, trophy: _selectedTrophyName!,);
    }

    if (_selectedNewsItem != null) {
      return NewsDetails( newsItem: _selectedNewsItem!,);
    }
    if (_selectedMatch != null) {
      return MatchDetailsPage( match: _selectedMatch!, onTeamSelected: _onTeamItemSelected);
    }

    if (_notifPressed) {
      return NotificationScreen(notifications: mockNotifications, );
    }

    // Show trophy screen if a trophy is selected
    if (_showTrophyScreen && _selectedTrophyName != null) {
      return TrophyScreen(
        trophyName: _selectedTrophyName!,
        onLeagueSelected: _onLeagueSelected, // Pass the callback to TrophyScreen
      );
    }

    if ( _selectedTeam != null) {
      return TeamPage(team: _selectedTeam!, onPlayerSelected: _onPlayerSelected,
        
      );
    }
    if ( _selectedPlayer != null) {
      return PlayerDetails(player: _selectedPlayer!,

      );
    }

    // Return the selected index page
    switch (selectedIndex) {
      case 0:
        return  HomeScreen(onNewsSelected: _onNewsItemSelected);
      case 1:
        return  MatchesScreen(onMatchSelected: _onMatchItemSelected);
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
