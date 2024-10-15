import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:untitled/Service/mock_data.dart';
import '../Service/data_service.dart';
import '../components/colors.dart';
import '../components/leagueFavoriteComponent.dart';
import '../models/Match.dart';
import '../models/League.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final DataService dataService = DataService();
  List<Match> matchesList = [];
  List<League> leaguesList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMatches();
    _fetchLeagues();
  }

  Future<List<int>> _loadFavoriteTeams() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteTeams = prefs.getStringList('favoriteTeams') ?? [];
    // Convert List<String> to List<int>
    return favoriteTeams.map((id) => int.parse(id)).toList();
  }


  Future<void> _fetchMatches() async {
    setState(() {
      isLoading = true;
    });

    try {
      final fetchedMatches = await dataService.fetchPlayedMatches();
      final favoriteTeamIds = await _loadFavoriteTeams();

      // Filter matches based on favorite teams
      matchesList = fetchedMatches.where((match) {
        return favoriteTeamIds.contains(match.home!.id) || favoriteTeamIds.contains(match.away!.id);
      }).toList();
    } catch (e) {
      print('Error fetching matches: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchLeagues() async {
    try {
      final  fetchedLeagues = await dataService.fetchLeagues(); // Replace with your actual fetching logic
      setState(() {
        leaguesList = fetchedLeagues;
      });
    } catch (e) {
      print('Error fetching leagues: $e');
    }
  }

  // Group matches by the league ID from match.home.league
  Map<League, List<Match>> _groupMatchesByLeague(List<Match> matches, List<League> leagues) {
    Map<League, List<Match>> groupedMatches = {};

    for (var league in leagues) {
      List<Match> leagueMatches = matches.where((match) => match.home!.league == league.id&&match.away!.league==league.id).toList();
      if (leagueMatches.isNotEmpty) {
        groupedMatches[league] = leagueMatches;
      }
    }

    return groupedMatches;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isLoading)
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        else if (matchesList.isEmpty) // Handle the case when no matches are found
          const Expanded(
            child: Center(
              child: Text(
                'No favorite matches found.',
                style: TextStyle(fontSize: 16, color: Colors.white), // Change color to your theme color
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 7),
              itemCount: _groupMatchesByLeague(matchesList, leaguesList).length,
              itemBuilder: (context, index) {
                final groupedMatches = _groupMatchesByLeague(matchesList, leaguesList);
                final league = groupedMatches.keys.elementAt(index);
                final matches = groupedMatches[league]!;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LeagueFavoriteComponent with matches for the respective league
                      LeagueFavoriteComponent(league: league, matches: matches),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
