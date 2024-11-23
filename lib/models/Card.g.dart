// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      player: json['player'] == null
          ? null
          : Player.fromJson(json['player'] as Map<String, dynamic>),
      min: json['min'] as String?,
      second_yellow: json['second_yellow'] as bool?,
      match: json['match'] == null
          ? null
          : Match.fromJson(json['match'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'player': instance.player?.toJson(),
      'min': instance.min,
      'second_yellow': instance.second_yellow,
      'match': instance.match?.toJson(),
    };
