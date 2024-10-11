// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlayerChange.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerChange _$PlayerChangeFromJson(Map<String, dynamic> json) => PlayerChange(
      id: (json['id'] as num).toInt(),
      playerOut: Player.fromJson(json['playerOut'] as Map<String, dynamic>),
      playerIn: Player.fromJson(json['playerIn'] as Map<String, dynamic>),
      min: json['min'] as String?,
      match: Match.fromJson(json['match'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerChangeToJson(PlayerChange instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerOut': instance.playerOut,
      'playerIn': instance.playerIn,
      'min': instance.min,
      'match': instance.match,
    };
