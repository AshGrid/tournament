import 'package:json_annotation/json_annotation.dart';
import 'package:untitled/models/Club.dart';
import 'package:untitled/models/Pool.dart';

part 'TeamRanking.g.dart';

@JsonSerializable()
class TeamRanking {
  Pool? pool;
  Club? club;
  int? points;
  int? win;
  int? loose;
  int? draw;
  int? goals_for;
  int? goals_against;
  int? goal_diff;
  int? yellow_cards;
  int? red_cards;

  TeamRanking({
    this.pool,
    this.club,
    required this.points,
    required this.win,
    required this.loose,
    required this.draw,
    required this.goals_for,
    required this.goals_against,
    required this.goal_diff,
    required this.yellow_cards,
    required this.red_cards,
  });

  // Factory method to create an instance from JSON

  factory TeamRanking.fromJson(Map<String, dynamic> json) => _$TeamRankingFromJson(json);
  Map<String, dynamic> toJson() => _$TeamRankingToJson(this);
  // Method to convert an instance to JSON

}
