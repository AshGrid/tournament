import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import '../Service/data_service.dart';
import '../components/LeagueComponent.dart';
import '../models/Club.dart';
import '../models/MatchEvent.dart';
import '../models/Team.dart';
import '../models/League.dart';
import '../models/Match.dart';
import '../models/Player.dart';
import 'TeamLeagueComponent.dart';

class TeamResults extends StatefulWidget {
  final Function(Match)? onMatchSelected;
  final Club club;

  const TeamResults({Key? key, this.onMatchSelected,required this.club}) : super(key: key);

  @override
  _TeamResultsState createState() => _TeamResultsState();
}

class _TeamResultsState extends State<TeamResults> {
  final DataService dataService = DataService();

  List<League> leaguesList = [];

  Future<void> _fetchLeagues() async {
    try {
      final fetchedLeagues = await dataService.fetchLeagues();
      print("Fetched leagues: $fetchedLeagues");

      // Filter leagues where the league ID matches widget.club.league
      final filteredLeagues = fetchedLeagues.where((league) {
        return league.id == widget.club.league;
      }).toList();

      setState(() {
        leaguesList = filteredLeagues;
        //  isLeaguesLoading = false; // Uncomment if needed
      });
    } catch (error) {
      print("Error fetching leagues: $error");
      setState(() {
        // isLeaguesLoading = false; // Uncomment if needed
      });
    }
  }


  @override
  void initState() {
    super.initState();

    _fetchLeagues();
  }


  // Sample list of leagues


  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: Container(
          height: MediaQuery.of(context).size.height*0.69,
          width:MediaQuery.of(context).size.width ,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 0),
            children: leaguesList.map((league) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                child: TeamLeagueComponent(league: league,),
              );
            }).toList(),
          ),
        )
    );
  }
}
