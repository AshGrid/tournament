// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goal _$GoalFromJson(Map<String, dynamic> json) => Goal(
      id: (json['id'] as num?)?.toInt(),
      player: json['player'] == null
          ? null
          : Player.fromJson(json['player'] as Map<String, dynamic>),
      assist: json['assist'] == null
          ? null
          : Player.fromJson(json['assist'] as Map<String, dynamic>),
      min: json['min'] as String?,
      match: json['match'] == null
          ? null
          : Match.fromJson(json['match'] as Map<String, dynamic>),
      is_penalty: json['is_penalty'] as bool?,
    );

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'id': instance.id,
      'player': instance.player?.toJson(),
      'assist': instance.assist?.toJson(),
      'min': instance.min,
      'match': instance.match?.toJson(),
      'is_penalty': instance.is_penalty,
    };
