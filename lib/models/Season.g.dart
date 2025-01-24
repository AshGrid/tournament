// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
      id: (json['id'] as num?)?.toInt(),
      season: json['season'] as String?,
      full_name: json['full_name'] as String?,
      league: json['league'] == null
          ? null
          : League.fromJson(json['league'] as Map<String, dynamic>),
      teams: (json['teams'] as List<dynamic>?)
          ?.map((e) => Club.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      'id': instance.id,
      'season': instance.season,
      'league': instance.league,
      'teams': instance.teams,
    };
