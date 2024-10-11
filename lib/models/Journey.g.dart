// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Journey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Journey _$JourneyFromJson(Map<String, dynamic> json) => Journey(
      id: (json['id'] as num?)?.toInt(),
      pool: json['pool'] == null
          ? null
          : Pool.fromJson(json['pool'] as Map<String, dynamic>),
      number: (json['number'] as num?)?.toInt(),
    );

Map<String, dynamic> _$JourneyToJson(Journey instance) => <String, dynamic>{
      'id': instance.id,
      'pool': instance.pool?.toJson(),
      'number': instance.number,
    };
