import 'package:json_annotation/json_annotation.dart';
import 'Club.dart'; // Import the Club model

part 'MatchEvent.g.dart';

@JsonSerializable() // Enable JSON serialization
class MatchEvent {
  final String description; // e.g., "Goal", "Yellow Card"
  final Club team; // The team involved in the event
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

  // JSON serialization methods
  factory MatchEvent.fromJson(Map<String, dynamic> json) => _$MatchEventFromJson(json);
  Map<String, dynamic> toJson() => _$MatchEventToJson(this);
}
