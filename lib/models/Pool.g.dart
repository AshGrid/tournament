// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Pool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pool _$PoolFromJson(Map<String, dynamic> json) => Pool(
      id: (json['id'] as num?)?.toInt(),
      premierePhase: json['premierePhase'] == null
          ? null
          : PremierePhase.fromJson(
              json['premierePhase'] as Map<String, dynamic>),
      teams: (json['teams'] as List<dynamic>?)
          ?.map((e) => Club.fromJson(e as Map<String, dynamic>))
          .toList(),
      createMatches: json['createMatches'] as bool?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$PoolToJson(Pool instance) => <String, dynamic>{
      'id': instance.id,
      'premierePhase': instance.premierePhase,
      'teams': instance.teams,
      'createMatches': instance.createMatches,
      'type': instance.type,
    };
