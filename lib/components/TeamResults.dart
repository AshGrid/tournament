import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import '../components/LeagueComponent.dart';
import '../models/MatchEvent.dart';
import '../models/Team.dart';
import '../models/League.dart';
import '../models/Match.dart';
import '../models/Player.dart';
import 'TeamLeagueComponent.dart';

class TeamResults extends StatefulWidget {
  final Function(Match)? onMatchSelected;

  const TeamResults({Key? key, this.onMatchSelected}) : super(key: key);

  @override
  _TeamResultsState createState() => _TeamResultsState();
}

class _TeamResultsState extends State<TeamResults> {
  // Sample list of leagues
  List<League> leagues = MockData.mockLeagues;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: Container(
          height: MediaQuery.of(context).size.height*0.69,
          width:MediaQuery.of(context).size.width ,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 0),
            children: leagues.map((league) {
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
