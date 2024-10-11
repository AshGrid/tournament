// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'League.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

League _$LeagueFromJson(Map<String, dynamic> json) => League(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      trophy: json['trophy'] == null
          ? null
          : Trophy.fromJson(json['trophy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LeagueToJson(League instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'trophy': instance.trophy?.toJson(),
    };
