// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Pool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pool _$PoolFromJson(Map<String, dynamic> json) => Pool(
      id: (json['id'] as num?)?.toInt(),
      premiere_phase: (json['premiere_phase'] as num?)?.toInt(),
      teams: (json['teams'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      create_matches: json['create_matches'] as bool?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      full_name: json['full_name'] as String?,
    );

Map<String, dynamic> _$PoolToJson(Pool instance) => <String, dynamic>{
      'id': instance.id,
      'premiere_phase': instance.premiere_phase,
      'teams': instance.teams,
      'create_matches': instance.create_matches,
      'type': instance.type,
    };
