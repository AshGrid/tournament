// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Penalty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Penalty _$PenaltyFromJson(Map<String, dynamic> json) => Penalty(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      club: json['club'] == null
          ? null
          : Club.fromJson(json['club'] as Map<String, dynamic>),
      match: json['match'] == null
          ? null
          : Match.fromJson(json['match'] as Map<String, dynamic>),
      player: json['player'] == null
          ? null
          : Player.fromJson(json['player'] as Map<String, dynamic>),
      min: json['min'] as String?,
    );

Map<String, dynamic> _$PenaltyToJson(Penalty instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'club': instance.club?.toJson(),
      'match': instance.match?.toJson(),
      'player': instance.player?.toJson(),
      'min': instance.min,
    };
