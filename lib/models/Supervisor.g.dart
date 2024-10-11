// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Supervisor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Supervisor _$SupervisorFromJson(Map<String, dynamic> json) => Supervisor(
      id: (json['id'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SupervisorToJson(Supervisor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'name': instance.name,
    };
