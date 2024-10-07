

import 'Team.dart';

class MatchEvent {

  final String description; // e.g., "Goal", "Yellow Card"
 final Team team;
  final String playerName; // Associated player's name (e.g., the one who scored)
  final DateTime time; // Time of the event
  final String? assistPlayerName; // Player who made the assist (optional)

  MatchEvent({
required this.team,
    required this.description,

    required this.playerName,
    required this.time,
    this.assistPlayerName, // Optional parameter for the assist player
  });
}