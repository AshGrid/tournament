import 'package:untitled/models/TeamRanking.dart';

import 'Pool.dart';
import 'Ranking.dart';
import 'Match.dart';

class PoolData {
  Pool? pool;
  List<TeamRanking>? rankings;
  List<Match>? playedMatches;
  List<Match>? upcomingMatches;

  PoolData({this.pool, this.rankings, this.playedMatches, this.upcomingMatches});

  factory PoolData.fromJson(Map<String, dynamic> json) {
    return PoolData(
      pool: json['pool'] != null ? Pool.fromJson(json['pool']) : null,
      rankings: (json['rankings'] as List<dynamic>?)
          ?.map((ranking) => TeamRanking.fromJson(ranking))
          .toList(),
      playedMatches: (json['played_matches'] as List<dynamic>?)
          ?.map((match) => Match.fromJson(match))
          .toList(),
      upcomingMatches: (json['upcoming_matches'] as List<dynamic>?)
          ?.map((match) => Match.fromJson(match))
          .toList(),
    );
  }
}