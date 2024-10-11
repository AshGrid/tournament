// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) => Story(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      file: json['file'] as String,
    );

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'file': instance.file,
    };
