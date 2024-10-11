// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      name: json['name'] as String?,
      players: (json['players'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
      remplacanats: (json['remplacanats'] as List<dynamic>?)
          ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'name': instance.name,
      'players': instance.players,
      'remplacanats': instance.remplacanats,
    };
