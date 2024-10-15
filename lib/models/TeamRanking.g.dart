// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeamRanking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamRanking _$TeamRankingFromJson(Map<String, dynamic> json) => TeamRanking(
      pool: json['pool'] == null
          ? null
          : Pool.fromJson(json['pool'] as Map<String, dynamic>),
      club: json['club'] == null
          ? null
          : Club.fromJson(json['club'] as Map<String, dynamic>),
      points: (json['points'] as num?)?.toInt(),
      win: (json['win'] as num?)?.toInt(),
      loose: (json['loose'] as num?)?.toInt(),
      draw: (json['draw'] as num?)?.toInt(),
      goals_for: (json['goals_for'] as num?)?.toInt(),
      goals_against: (json['goals_against'] as num?)?.toInt(),
      goal_diff: (json['goal_diff'] as num?)?.toInt(),
      yellow_cards: (json['yellow_cards'] as num?)?.toInt(),
      red_cards: (json['red_cards'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TeamRankingToJson(TeamRanking instance) =>
    <String, dynamic>{
      'pool': instance.pool,
      'club': instance.club,
      'points': instance.points,
      'win': instance.win,
      'loose': instance.loose,
      'draw': instance.draw,
      'goals_for': instance.goals_for,
      'goals_against': instance.goals_against,
      'goal_diff': instance.goal_diff,
      'yellow_cards': instance.yellow_cards,
      'red_cards': instance.red_cards,
    };
