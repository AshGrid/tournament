import 'package:json_annotation/json_annotation.dart';
import 'Club.dart';
import 'Player.dart';
import 'Match.dart';



part 'Penalty.g.dart';

@JsonSerializable(explicitToJson: true)
class Penalty {
  int? id;
  String? status; // 'goal' or 'miss'
  Club? club;
  Match? match;
  Player? player;
  String? min;

  Penalty({
     this.id,
    required this.status,
    required this.club,
    required this.match,
    required this.player,
     this.min,
  });

  factory Penalty.fromJson(Map<String, dynamic> json) => _$PenaltyFromJson(json);
  Map<String, dynamic> toJson() => _$PenaltyToJson(this);
}