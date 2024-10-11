import 'package:json_annotation/json_annotation.dart';
import 'Player.dart'; // Assuming Player model is defined

part 'Team.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class Team {
  final int rank;
  final String name;
  final int matchesPlayed;
  final int goals;
  final int points;
  final String logo;
  final List<Player>? players;
  final List<Player>? remplacanats;
  final String? league;

  Team({
    required this.rank,
    required this.name,
    required this.matchesPlayed,
    required this.goals,
    required this.points,
    required this.logo,
    this.players,
    this.remplacanats,
    this.league,
  });

  // JSON serialization methods
  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
