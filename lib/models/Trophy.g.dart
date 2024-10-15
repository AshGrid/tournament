// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Trophy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trophy _$TrophyFromJson(Map<String, dynamic> json) {

  try {
    return Trophy(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      image: json['image'] as String?,
      date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
      active: json['active'] as bool,
    );
  } catch (e) {
    print('Error deserializing Trophy: $e');
    print('Offending JSON: $json');
    rethrow;
  }
}

Map<String, dynamic> _$TrophyToJson(Trophy instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'date': instance.date?.toIso8601String(),
      'active': instance.active,
    };
