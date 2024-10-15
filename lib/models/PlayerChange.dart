import 'package:json_annotation/json_annotation.dart';
import 'Player.dart'; // Import your Player model
import 'Match.dart'; // Import your Match model

part 'PlayerChange.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class PlayerChange {
  final int? id;
  final Player? player_out;
  final Player? player_in;
  final String? min;
  final Match match;

  PlayerChange({
    required this.id,
    required this.player_out,
    required this.player_in,
    required this.min,
    required this.match,
  });

  // JSON serialization methods
  factory PlayerChange.fromJson(Map<String, dynamic> json) => _$PlayerChangeFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerChangeToJson(this);
}
