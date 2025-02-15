import 'package:json_annotation/json_annotation.dart';
import 'Player.dart'; // Import the Player model
import 'Match.dart'; // Import the Match model

part 'Goal.g.dart';

@JsonSerializable(explicitToJson: true) // Enable explicit to JSON serialization for nested objects
class Goal {
  final int? id;
  final Player? player;
  final Player? assist;
  final String? min;
  final Match? match;
  final bool? is_penalty;
  final bool? is_own_goal;

  Goal({
    required this.id,
    required this.player,
    this.assist,
    required this.min,
    required this.match,
    this.is_penalty,
    this.is_own_goal,
  });

  // JSON serialization methods
  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);
  Map<String, dynamic> toJson() => _$GoalToJson(this);
}
