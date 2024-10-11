import 'Arbitre.dart';
import 'Club.dart';
import 'Journey.dart';
import 'PremierePhase.dart';
import 'Season.dart';
import 'Supervisor.dart';
import 'Trophy.dart';
import 'Venue.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Match.g.dart';

@JsonSerializable(explicitToJson: true)
class Match {
  final int? id;
  final Club? home;
  final Club? away;
  final DateTime? date;
  final Venue? venue; // Venue can be nullable
  final List<Arbitre>? arbitres;
  final List<Supervisor>? supervisors; // Nullable field
  final int? home_first_half_score;
  final int? away_first_half_score;
  final int? home_second_half_score;
  final int? away_second_half_score;
  final String? status; // Make sure status can handle null values
  final bool? is_ended;
  final Trophy? trophy; // Nullable Trophy
  final Season? season; // Nullable Season
  final PremierePhase? premierePhase; // Nullable PremierePhase
  final bool? is_premiere_phase;
  final bool? is_playoff;
  final bool? is_trophy;
  final bool? is_super_trophy;
  final bool? is_super_playoff;
  final bool? is_coupe;
  final bool? is_super_coupe;
  final Journey? journey; // Nullable Journey

  Match({
    required this.id,
    required this.home,
    required this.away,
    this.date,
    this.venue,
    required this.arbitres,
    this.supervisors,
    required this.home_first_half_score,
    required this.away_first_half_score,
    required this.home_second_half_score,
    required this.away_second_half_score,
    required this.status,
    required this.is_ended,
    this.trophy,
    this.season,
    this.premierePhase,
    required this.is_premiere_phase,
    required this.is_playoff,
    required this.is_trophy,
    required this.is_super_trophy,
    required this.is_super_playoff,
    required this.is_coupe,
    required this.is_super_coupe,
    this.journey,
  });
  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);
  Map<String, dynamic> toJson() => _$MatchToJson(this);

}
