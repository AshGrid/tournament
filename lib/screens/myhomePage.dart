import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/models/Club.dart';
import 'package:untitled/models/Team.dart';
import 'package:untitled/models/News.dart';
import 'package:untitled/models/Player.dart';
import 'package:untitled/models/Trophy.dart';
import 'package:untitled/screens/PlayerDetails.dart';
import 'package:untitled/screens/StreamingScreen.dart';
import 'package:untitled/screens/bestMoments.dart';
import 'package:untitled/screens/fantasy_screen.dart';
import 'package:untitled/screens/match_details.dart';
import 'package:untitled/screens/matches_screen.dart';
import 'package:untitled/screens/home_screen.dart';
import 'package:untitled/screens/fovorite_screen.dart';
import 'package:untitled/screens/notificationScreen.dart';
import 'package:untitled/screens/profile_screen.dart';
import 'package:untitled/screens/searchScreeen.dart';
import 'package:untitled/screens/splash_screen.dart';
import 'package:untitled/screens/teamPage.dart';
import 'package:untitled/screens/trophy_screen.dart';

import '../Service/data_service.dart';
import '../components/bottom_navigation.dart';
import '../components/colors.dart';
import '../components/custom_appbar.dart';
import '../models/Coupe.dart';
import '../models/Coupe8.dart';
import '../models/Notif.dart';
import '../models/League.dart';
import '../models/Match.dart';
import '../models/Season.dart';
import 'LeagueDetailsScreen.dart';
import 'coupeDetailsScreen.dart';
import 'coupe_8_details.dart';
import 'menu_screen.dart';
import 'newsDetails.dart';
import 'newsScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool _showTrophyScreen = false;
  Trophy? _selectedTrophyName;
  League? _selectedLeague;
  Coupe? _selectedCoupe;
  Coupe8? _selectedCoupe8;
  News? _selectedNewsItem;
  bool _notifPressed = false;
  Match? _selectedMatch;
  Club? _selectedTeam;
  Player? _selectedPlayer;
  bool _newsPage = false;
  bool _streamPage = false;
  bool _MomentsPage = false;
  String _query = '';
  List<String> savedClubs = [];
  int notifCount = 0;



  Future<void> _loadSavedClubsAndNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedClubs = prefs.getStringList('favoriteTeams') ?? [];
    print("saved clubs homepage");
    print(savedClubs);

  }







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
      _selectedCoupe = null;
      _selectedCoupe8 = null;
      _newsPage = false;
      _streamPage = false;
      _MomentsPage = false;
      _showSearchResults = false;
    });
  }
  bool isSeasonsLoading = true;
  List<String> seasons = [];
  List<Season> seasonsList = [];

  Season? selectedSeason;

  Future<void> _fetchSeasons(Trophy trophy) async {
    try {
      setState(() {
        isSeasonsLoading = true;
      });
      final fetchedSeasons = await dataService.fetchSeasons();
      setState(() {

        seasonsList = fetchedSeasons.where((season) {
          return season.league?.trophy?.id == trophy.id;
        }).toList(); // Filter full Season objects here

        // Assign filtered seasons to `seasonsList`
        if (seasonsList.isNotEmpty) {
          selectedSeason = seasonsList[0]; // Set the first filtered season as selected
        }

        isSeasonsLoading = false;
      });

      print("Filtered seasons list: $seasonsList");
    } catch (e) {
      print('Error fetching seasons: $e');
      setState(() {
        isSeasonsLoading = false;
      });
    }
  }


  void _onTrophySelected(Trophy trophy) {
    setState(() {
      _showTrophyScreen = true;
      _selectedTrophyName = trophy;
      _selectedLeague = null; // Reset league when selecting a new trophy
      _selectedNewsItem = null;
      _selectedMatch = null;
      _selectedTeam = null;
      _notifPressed = false;
      _selectedPlayer = null;
      _selectedCoupe = null;
      _selectedCoupe8 = null;
      _newsPage = false;
      _streamPage = false;
      _MomentsPage = false;
      _showSearchResults = false;
      _fetchSeasons(trophy);
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
      _selectedCoupe = null;
      _selectedCoupe8 = null;
      _selectedPlayer = null;
      _newsPage = false;
      _streamPage = false;
      _MomentsPage = false;
      _showSearchResults = false;
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
      _showSearchResults = false;
    });
  }
  void _onCoupeSelected(Coupe coupe) {
    setState(() {
      _selectedLeague = null; // Update with the selected league
      _selectedNewsItem = null;
      _selectedMatch = null;
      _selectedTeam = null;
      _notifPressed = false;
      _selectedPlayer = null;
      _selectedCoupe = coupe;
      _showSearchResults = false;
    });
  }

  void _onCoupe8Selected(Coupe8 coupe) {
    setState(() {
      _selectedLeague = null; // Update with the selected league
      _selectedNewsItem = null;
      _selectedMatch = null;
      _selectedTeam = null;
      _notifPressed = false;
      _selectedPlayer = null;
      _selectedCoupe = null;
      _selectedCoupe8 = coupe;
      _showSearchResults = false;
    });
  }
    void _onValueChanged(String query) {
    setState(() {
      _selectedLeague = null; // Update with the selected league
      _selectedNewsItem = null;
      _selectedMatch = null;
      _selectedTeam = null;
      _notifPressed = false;
      _selectedPlayer = null;
      _selectedCoupe = null;
      _selectedCoupe8 = null;
      _query = query;
      _showSearchResults = true;
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
      _selectedTrophyName = null;
      _selectedLeague = null; // Update with the selected league
      _selectedNewsItem = null;

      _selectedTeam = null;
      _notifPressed = false;
      _selectedPlayer = null;
      _selectedCoupe = null;
      _selectedCoupe8 = null;

      _showSearchResults = false;
    });
  }
  void _onNewsTapped ( ) {
    setState(() {
      _newsPage = true; // Update with the selected league
    });
  }
  void _onStreamTapped ( ) {
    setState(() {
      _streamPage = true; // Update with the selected league
    });
  }

  void _onMomentsTapped ( ) {
    setState(() {
      _MomentsPage = true; // Update with the selected league
    });
  }

  void _onTeamItemSelected(Club team) {
    setState(() {
      _selectedTeam = team;
      _selectedMatch = null;
      _selectedPlayer = null;
      _showSearchResults = false;
    });
  }
  void _onPlayerSelected(Player player) {
    setState(() {
      _selectedTeam = null;
      _selectedMatch = null;
      _selectedPlayer = player;
    });
  }
  bool _showSearchResults = false; // Controls the visibility of SearchScreen
  List<Match> allMatches = []; // Placeholder for matches list
  final DataService dataService = DataService();


  DateTime? parseMatchDate(String dateString, String timeString) {
    // Example date and time format: 'MM/DD/YYYY' and 'HH:mm'
    final dateFormat = DateFormat('yyyy-MM-dd'); // Change this to match your date format
    final timeFormat = DateFormat('HH:mm');

    try {
      DateTime date = dateFormat.parse(dateString);
      DateTime time = timeFormat.parse(timeString);
      // Combine date and time
      return DateTime(date.year, date.month, date.day, time.hour, time.minute);
    } catch (e) {
      print('Error parsing date or time: $e');
      return null; // Handle the error as needed
    }
  }

  Future<void> _fetchMatches() async {
    try {
      // Fetch all upcoming matches from your data service
      final fetchedUpcomingMatches = await dataService.fetchUpcomingMatches();

      // Get the current time
      final now = DateTime.now();

      // Define the time thresholds
      final oneHourFromNow = now.add(Duration(hours: 1));
      final oneDayFromNow = now.add(Duration(days: 1));

      // Print all fetched matches' dates and times for debugging


      // Filter matches based on the conditions
      final filteredMatches = fetchedUpcomingMatches.where((match) {
        // Ensure home and away objects are not null before accessing their ids
        bool isInSavedClubs = savedClubs.contains(match.home?.id.toString()) ||
            savedClubs.contains(match.away?.id.toString());



        // Parse time string and combine with matchDate
        if (match.date != null && match.time != null) {
          final timeParts = match.time?.split(':');
          if (timeParts?.length == 3) {
            final hour = int.tryParse(timeParts![0]) ?? 0;
            final minute = int.tryParse(timeParts[1]) ?? 0;

            // Create a DateTime object for the match time
            final matchDateTime = DateTime(
              match.date!.year,
              match.date!.month,
              match.date!.day,
              hour,
              minute,
            );

            // Check if the match is live or within the specified time frames
            return isInSavedClubs &&
                (matchDateTime.isAfter(now) && matchDateTime.isBefore(oneHourFromNow) ||
                    matchDateTime.isAfter(oneHourFromNow) && matchDateTime.isBefore(oneDayFromNow) ||
                    match.status == 'live');
          }
        }
        return false; // Return false if conditions aren't met
      }).toList();

      // Print filtered matches' details for debugging


      // Update the state with the filtered matches
      if (mounted) {
        setState(() {
          allMatches = filteredMatches;
          notifCount = filteredMatches.length;

        });
      }

    } catch (error) {
      // Handle errors and stop loading state
      if (mounted) {
        setState(() {

        });
      }
      print('Error fetching matches: $error'); // Optional: Add logging for the error
    }
  }


  @override
  void initState() {
    super.initState();
    _fetchMatches();
    _loadSavedClubsAndNotifications();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nav,
       // endDrawer: Drawer(
       //   width: MediaQuery.of(context).size.width > 600
       //       ? MediaQuery.of(context).size.width * 0.6
       //       : MediaQuery.of(context).size.width * 0.8,
       //   child: ProfileScreen(),
       // ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundColor,
        ),
        child: ClipRRect(
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                CustomAppBar(onTrophySelected: _onTrophySelected, onNotifPressed: _onNotifPressed,onSearchQueryChanged: _onValueChanged,
              onSearchClosed: () {
              setState(() {
              _showSearchResults = false;
              });
              },
              allMatches: allMatches,
                  notifCount: notifCount,

              ),

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
      return LeagueDetailsScreen(league: _selectedLeague!, trophy: _selectedTrophyName!, onMatchSelected: _onMatchItemSelected,);
    }
    if (_selectedCoupe != null) {
      return CoupeDetailsScreen(coupe: _selectedCoupe!,  trophyName: _selectedTrophyName!,);
    }

    if (_selectedCoupe8 != null) {
      return Coupe8DetailsScreen(coupe8: _selectedCoupe8!,  trophyName: _selectedTrophyName!,);
    }

    if (_selectedNewsItem != null) {
      return NewsDetails( newsItem: _selectedNewsItem!,);
    }
    if (_selectedMatch != null) {
      return MatchDetailsPage( match: _selectedMatch!, onTeamSelected: _onTeamItemSelected);
    }
    if (_newsPage ) {
      return NewsScreen(  onNewsTapped: _newsPage, onNewsSelected: _onNewsItemSelected,);
    }
    if (_MomentsPage ) {
      return Bestmoments(  );
    }
    if (_streamPage ) {
      return StreamingScreen( );
    }
    if (_notifPressed) {
      setState(() {
        notifCount = 0;
      });
      return NotificationScreen(savedClubs: savedClubs, );
    }
    if (_showSearchResults)
      {
        return SearchScreen(query: _query, matches: allMatches, onMatchSelected: _onMatchItemSelected);
      }

    // Show trophy screen if a trophy is selected
    if (_showTrophyScreen && _selectedTrophyName != null) {
      return TrophyScreen(
        seasonsList: seasonsList,
        trophyName: _selectedTrophyName!,
        onLeagueSelected: _onLeagueSelected, onCoupeSelected: _onCoupeSelected, onCoupe8Selected: _onCoupe8Selected, isSeasonsLoading: isSeasonsLoading, selectedSeason: selectedSeason , // Pass the callback to TrophyScreen
      );
    }

    if ( _selectedTeam != null) {
      return TeamPage(team: _selectedTeam!, onPlayerSelected: _onPlayerSelected, onMatchSelected: _onMatchItemSelected
        
      );
    }
    if ( _selectedPlayer != null) {
      return PlayerDetails(player: _selectedPlayer!,

      );
    }

    // Return the selected index page
    switch (selectedIndex) {
      case 0:
        return  HomeScreen(onNewsSelected: _onNewsItemSelected, onTeamSelected: _onTeamItemSelected,onMatchSelected: _onMatchItemSelected,);
      case 1:
        return  MatchesScreen(onMatchSelected: _onMatchItemSelected);
      case 2:
        return  FavoriteScreen(onMatchSelected: _onMatchItemSelected);
      case 3:
        return  FantasyScreen(onMatchSelected: _onMatchItemSelected);
      case 4:
        return  MenuScreen(onNewsTapped: _onNewsTapped, onStreamTapped: _onStreamTapped, onMomentsTapped: _onMomentsTapped,);
      default:
        return const SizedBox();
    }
  }
}
