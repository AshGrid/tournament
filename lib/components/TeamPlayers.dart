import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import '../components/LeagueComponent.dart';
import '../models/Club.dart';
import '../models/MatchEvent.dart';
import '../models/Position.dart';
import '../models/Team.dart';
import '../models/League.dart';
import '../models/Match.dart';
import '../models/Player.dart';
import 'TeamLeagueComponent.dart';
import 'TeamPositionComponent.dart';

class TeamPlayers extends StatefulWidget {
  final Club team;
  final Function(Player) onPlayerSelected;

  const TeamPlayers({Key? key, required this.team, required this.onPlayerSelected}) : super(key: key);

  @override
  _TeamPlayersState createState() => _TeamPlayersState();
}

class _TeamPlayersState extends State<TeamPlayers> {
  // Sample list of leagues
  List<Position> positions = [
    Position(name: 'Guardiens',
      players: [],),
    Position(name: 'Défenseurs',  players: [] ,),
    Position(name: 'Défenseurs',  players: [],


    )
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          height: MediaQuery.of(context).size.height*0.55,
          width:MediaQuery.of(context).size.width ,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 0),
            children: positions.map((position) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                child: TeamPositionComponent(position: position, onPlayerSelected: widget.onPlayerSelected,),
              );
            }).toList(),
          ),
        )
    );
  }
}


