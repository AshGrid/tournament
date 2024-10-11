import 'package:json_annotation/json_annotation.dart';
import 'League.dart'; // Assuming League model is defined
import 'Club.dart'; // Assuming Club model is defined

part 'Season.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class Season {
  final int? id;
  final String? season;
  final League? league;
  final List<Club>? teams;

  Season({
    required this.id,
    required this.season,
    required this.league,
    required this.teams,
  });

  // JSON serialization methods
  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);
  Map<String, dynamic> toJson() => _$SeasonToJson(this);
}
