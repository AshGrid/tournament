// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlayerChange.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerChange _$PlayerChangeFromJson(Map<String, dynamic> json) => PlayerChange(
      id: (json['id'] as num?)?.toInt(),
      player_out: json['player_out'] == null
          ? null
          : Player.fromJson(json['player_out'] as Map<String, dynamic>),
      player_in: json['player_in'] == null
          ? null
          : Player.fromJson(json['player_in'] as Map<String, dynamic>),
      min: json['min'] as String?,
      match: Match.fromJson(json['match'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerChangeToJson(PlayerChange instance) =>
    <String, dynamic>{
      'id': instance.id,
      'player_out': instance.player_out,
      'player_in': instance.player_in,
      'min': instance.min,
      'match': instance.match,
    };
