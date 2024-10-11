// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      rank: (json['rank'] as num).toInt(),
      name: json['name'] as String,
      matchesPlayed: (json['matchesPlayed'] as num).toInt(),
      goals: (json['goals'] as num).toInt(),
      points: (json['points'] as num).toInt(),
      logo: json['logo'] as String,
      players: (json['players'] as List<dynamic>?)
          ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
      remplacanats: (json['remplacanats'] as List<dynamic>?)
          ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
      league: json['league'] as String?,
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'rank': instance.rank,
      'name': instance.name,
      'matchesPlayed': instance.matchesPlayed,
      'goals': instance.goals,
      'points': instance.points,
      'logo': instance.logo,
      'players': instance.players,
      'remplacanats': instance.remplacanats,
      'league': instance.league,
    };
