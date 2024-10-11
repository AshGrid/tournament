import 'package:json_annotation/json_annotation.dart';
import 'Club.dart';      // Import the Club model
import 'Player.dart';   // Import the Player model
import 'Match.dart';    // Import the Match model

part 'InvitedPlayers.g.dart';

@JsonSerializable(explicitToJson: true) // Enable explicit to JSON serialization for nested objects
class InvitedPlayers {
  final int? id;
  final Club? club;
  final List<Player>? compositionsDeDepart;
  final List<Player>? remplacants;
  final Match? match;

  InvitedPlayers({
    required this.id,
    required this.club,
    required this.compositionsDeDepart,
    required this.remplacants,
    required this.match, // Ensure non-nullable
  });

  // JSON serialization methods
  factory InvitedPlayers.fromJson(Map<String, dynamic> json) => _$InvitedPlayersFromJson(json);
  Map<String, dynamic> toJson() => _$InvitedPlayersToJson(this);
}
