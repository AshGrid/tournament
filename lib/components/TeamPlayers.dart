import 'package:flutter/material.dart';
import '../components/LeagueComponent.dart';
import '../models/MatchEvent.dart';
import '../models/Position.dart';
import '../models/Team.dart';
import '../models/league.dart';
import '../models/match.dart';
import '../models/player.dart';
import 'TeamLeagueComponent.dart';
import 'TeamPositionComponent.dart';

class TeamPlayers extends StatefulWidget {
  final Team team;
  final Function(Player) onPlayerSelected;

  const TeamPlayers({Key? key, required this.team, required this.onPlayerSelected}) : super(key: key);

  @override
  _TeamPlayersState createState() => _TeamPlayersState();
}

class _TeamPlayersState extends State<TeamPlayers> {
  // Sample list of leagues
  List<Position> positions = [
    Position(name: 'Guardiens',
      players: [
        Player(age:25,dateNaissance:  DateTime(1999, 7, 15),name: 'Player A1', position: 'Forward', image: 'assets/images/ennakl.jpg',team: Team(name: 'Ennakl', rank: 1, matchesPlayed: 12, goals: 15, points: 25, logo: 'assets/images/ennakl.jpg'),),

        Player(name: 'Player B1', position: 'Guardien', image: 'assets/images/monoprix.jpg'),
      Player(name: 'Player B1', position: 'Guardien', image: 'assets/images/monoprix.jpg'),
      Player(name: 'Player B1', position: 'Guardien', image: 'assets/images/monoprix.jpg'),
      Player(name: 'Player B1', position: 'Guardien', image: 'assets/images/monoprix.jpg'),
      Player(name: 'Player B1', position: 'Guardien', image: 'assets/images/monoprix.jpg'),
    ],),
    Position(name: 'Défenseurs',  players: [
      Player(name: 'Player B1', position: 'Guardien', image: 'assets/images/monoprix.jpg'),
      Player(name: 'Player B1', position: 'Guardien', image: 'assets/images/monoprix.jpg'),
      Player(name: 'Player B1', position: 'Guardien', image: 'assets/images/monoprix.jpg'),
      Player(name: 'Player B1', position: 'Guardien', image: 'assets/images/monoprix.jpg'),
      Player(name: 'Player B1', position: 'Guardien', image: 'assets/images/monoprix.jpg'),
      // Add more players as needed
    ],),
    Position(name: 'Défenseurs',  players: [
      Player(name: 'Player B1', position: 'Guardien', image: 'assets/images/monoprix.jpg'),
      Player(name: 'Player B1', position: 'Guardien', image: 'assets/images/monoprix.jpg'),
      Player(name: 'Player B1', position: 'Guardien', image: 'assets/images/monoprix.jpg'),
      Player(name: 'Player B1', position: 'Guardien', image: 'assets/images/monoprix.jpg'),
      Player(name: 'Player B1', position: 'Guardien', image: 'assets/images/monoprix.jpg'),
      // Add more players as needed
    ],


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


