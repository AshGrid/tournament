import 'package:json_annotation/json_annotation.dart';

part 'Teams.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class Teams {
  final String name;
  final int matches;
  final int goals;
  final int assists;
  final int yellowCards;
  final int redCards;
  final String logo;
  final String saison;

  Teams({
    required this.name,
    required this.matches,
    required this.goals,
    required this.assists,
    required this.yellowCards,
    required this.redCards,
    required this.logo,
    required this.saison,
  });

  // JSON serialization methods
  factory Teams.fromJson(Map<String, dynamic> json) => _$TeamsFromJson(json);
  Map<String, dynamic> toJson() => _$TeamsToJson(this);
}
