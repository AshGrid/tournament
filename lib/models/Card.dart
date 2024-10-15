import 'package:json_annotation/json_annotation.dart';
import 'Player.dart';
import 'Match.dart';

part 'Card.g.dart';

@JsonSerializable(explicitToJson: true)
class Card {
  final int? id;
  final String? type;
  final Player? player;
  final String? min;
  final bool? secondYellow;
  final Match? match;

  Card({
    required this.id,
    required this.type,
    required this.player,
    required this.min,
    required this.secondYellow,
    required this.match,
  });

  // JSON serialization methods
  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);
  Map<String, dynamic> toJson() => _$CardToJson(this);
}
