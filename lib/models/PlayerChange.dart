import 'package:json_annotation/json_annotation.dart';
import 'Player.dart'; // Import your Player model
import 'Match.dart'; // Import your Match model

part 'PlayerChange.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class PlayerChange {
  final int id;
  final Player playerOut;
  final Player playerIn;
  final String? min;
  final Match match;

  PlayerChange({
    required this.id,
    required this.playerOut,
    required this.playerIn,
    required this.min,
    required this.match,
  });

  // JSON serialization methods
  factory PlayerChange.fromJson(Map<String, dynamic> json) => _$PlayerChangeFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerChangeToJson(this);
}
