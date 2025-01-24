// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Moment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Moment _$MomentFromJson(Map<String, dynamic> json) => Moment(
      id: (json['id'] as num).toInt(),
      video: json['video'] as String,
      name: json['name'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MomentToJson(Moment instance) => <String, dynamic>{
      'id': instance.id,
      'video': instance.video,
      'name': instance.name,
      'created_at': instance.created_at.toIso8601String(),
    };
