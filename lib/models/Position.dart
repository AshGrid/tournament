import 'package:json_annotation/json_annotation.dart';
import 'Player.dart'; // Assuming Player model is defined

part 'Position.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class Position {
  final String? name;
  final List<Player> players;
  final List<Player>? remplacanats;

  Position({
    required this.name,
    required this.players,
    this.remplacanats,
  });

  // JSON serialization methods
  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);
  Map<String, dynamic> toJson() => _$PositionToJson(this);
}
