// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InvitedPlayers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitedPlayers _$InvitedPlayersFromJson(Map<String, dynamic> json) =>
    InvitedPlayers(
      id: (json['id'] as num?)?.toInt(),
      club: json['club'] == null
          ? null
          : Club.fromJson(json['club'] as Map<String, dynamic>),
      compositionsDeDepart: (json['compositionsDeDepart'] as List<dynamic>?)
          ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
      remplacants: (json['remplacants'] as List<dynamic>?)
          ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
      match: json['match'] == null
          ? null
          : Match.fromJson(json['match'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvitedPlayersToJson(InvitedPlayers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'club': instance.club?.toJson(),
      'compositionsDeDepart':
          instance.compositionsDeDepart?.map((e) => e.toJson()).toList(),
      'remplacants': instance.remplacants?.map((e) => e.toJson()).toList(),
      'match': instance.match?.toJson(),
    };
