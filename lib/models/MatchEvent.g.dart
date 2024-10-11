// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MatchEvent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchEvent _$MatchEventFromJson(Map<String, dynamic> json) => MatchEvent(
      team: Club.fromJson(json['team'] as Map<String, dynamic>),
      description: json['description'] as String,
      playerName: json['playerName'] as String,
      time: DateTime.parse(json['time'] as String),
      assistPlayerName: json['assistPlayerName'] as String?,
    );

Map<String, dynamic> _$MatchEventToJson(MatchEvent instance) =>
    <String, dynamic>{
      'description': instance.description,
      'team': instance.team,
      'playerName': instance.playerName,
      'time': instance.time.toIso8601String(),
      'assistPlayerName': instance.assistPlayerName,
    };
