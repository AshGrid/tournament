import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import '../Service/data_service.dart';
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
  List<Player> players = [];
  final DataService dataService = DataService();

  // This will hold the positions and their corresponding players
  Map<String, List<Player>> groupedPlayers = {};

  Future<void> _fetchPlayers() async {
    final fetchedPlayers = await dataService.fetchPlayers(widget.team.id!);

    // Group players by position
    setState(() {
      players = fetchedPlayers;


      for (var player in players) {
        // Assuming player.position is a String that holds the position name
        if (groupedPlayers.containsKey(player.position)) {
          groupedPlayers[player.position]!.add(player);
        } else {
          groupedPlayers[player.position!] = [player];
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: const EdgeInsets.only(bottom: 50),
        height: MediaQuery.of(context).size.height * 0.62,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 0),
          children: groupedPlayers.entries.map((entry) {
            String position = entry.key;
            List<Player> playersInPosition = entry.value;

            // Create a Position object for each position
            Position positionData = Position(name: position, players: playersInPosition);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              child: TeamPositionComponent(
                position: positionData,
                onPlayerSelected: widget.onPlayerSelected,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
