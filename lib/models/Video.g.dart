// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
      id: (json['id'] as num).toInt(),
      lien: json['file'] as String?,
      order: (json['order'] as num).toInt(),
      story: (json['story'] as num).toInt(),
    );

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'id': instance.id,
      'lien': instance.lien,
      'order': instance.order,
      'story': instance.story,
    };
