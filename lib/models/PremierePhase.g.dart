// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PremierePhase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PremierePhase _$PremierePhaseFromJson(Map<String, dynamic> json) =>
    PremierePhase(
      id: (json['id'] as num?)?.toInt(),
      season: json['season'] == null
          ? null
          : Season.fromJson(json['season'] as Map<String, dynamic>),
      type: json['type'] as String?,
      createPool: json['createPool'] as bool?,
      createMatch: json['createMatch'] as bool?,
      automaticJourney: json['automaticJourney'] as bool?,
    );

Map<String, dynamic> _$PremierePhaseToJson(PremierePhase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'season': instance.season,
      'type': instance.type,
      'createPool': instance.createPool,
      'createMatch': instance.createMatch,
      'automaticJourney': instance.automaticJourney,
    };
