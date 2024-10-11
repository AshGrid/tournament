// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Moment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Moment _$MomentFromJson(Map<String, dynamic> json) => Moment(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      file: json['file'] as String?,
    );

Map<String, dynamic> _$MomentToJson(Moment instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'file': instance.file,
    };
