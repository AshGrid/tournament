// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Teams.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teams _$TeamsFromJson(Map<String, dynamic> json) => Teams(
      name: json['name'] as String,
      matches: (json['matches'] as num).toInt(),
      goals: (json['goals'] as num).toInt(),
      assists: (json['assists'] as num).toInt(),
      yellowCards: (json['yellowCards'] as num).toInt(),
      redCards: (json['redCards'] as num).toInt(),
      logo: json['logo'] as String,
      saison: json['saison'] as String,
    );

Map<String, dynamic> _$TeamsToJson(Teams instance) => <String, dynamic>{
      'name': instance.name,
      'matches': instance.matches,
      'goals': instance.goals,
      'assists': instance.assists,
      'yellowCards': instance.yellowCards,
      'redCards': instance.redCards,
      'logo': instance.logo,
      'saison': instance.saison,
    };
