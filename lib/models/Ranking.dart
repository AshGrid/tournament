import 'Club.dart';
import 'Pool.dart';

class RamadanRanking {
  int? id;
  Club? club;
  Pool? pool;
  int? points;
  int? win;
  int? loose;
  int? draw;
  int? goalsFor;
  int? goalsAgainst;
  int? goalDiff;
  int? yellowCards;
  int? redCards;
  String? fullName;

  RamadanRanking({
    this.id,
    this.club,
    this.pool,
    this.points,
    this.win,
    this.loose,
    this.draw,
    this.goalsFor,
    this.goalsAgainst,
    this.goalDiff,
    this.yellowCards,
    this.redCards,
    this.fullName,
  });

  factory RamadanRanking.fromJson(Map<String, dynamic> json) {
    return RamadanRanking(
      id: json['id'],
      club: json['club'] != null ? Club.fromJson(json['club']) : null,
      pool: json['pool'] != null ? Pool.fromJson(json['pool']) : null,
      points: json['points'],
      win: json['win'],
      loose: json['loose'],
      draw: json['draw'],
      goalsFor: json['goals_for'],
      goalsAgainst: json['goals_against'],
      goalDiff: json['goal_diff'],
      yellowCards: json['yellow_cards'],
      redCards: json['red_cards'],
      fullName: json['full_name'],
    );
  }
}