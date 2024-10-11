// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Stream.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamItem _$StreamItemFromJson(Map<String, dynamic> json) => StreamItem(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$StreamItemToJson(StreamItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
    };
