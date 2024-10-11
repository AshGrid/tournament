import 'package:json_annotation/json_annotation.dart';
import 'Trophy.dart'; // Import the Trophy model
import 'Match.dart';  // Import the Match model

part 'League.g.dart';

@JsonSerializable(explicitToJson: true) // Enable explicit to JSON serialization for nested objects
class League {
  final int? id;
  final String? name;
  late final Trophy? trophy; // Nullable Trophy


  League({
    required this.id,
    required this.name,
    this.trophy,

  });

  // JSON serialization methods
  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);
  Map<String, dynamic> toJson() => _$LeagueToJson(this);
}
