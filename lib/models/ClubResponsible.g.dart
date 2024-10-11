// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ClubResponsible.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubResponsible _$ClubResponsibleFromJson(Map<String, dynamic> json) =>
    ClubResponsible(
      id: (json['id'] as num?)?.toInt(),
      post: json['post'] as String?,
      numBureau: json['numBureau'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      cin: json['cin'] as String?,
      club: json['club'] == null
          ? null
          : Club.fromJson(json['club'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClubResponsibleToJson(ClubResponsible instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post': instance.post,
      'numBureau': instance.numBureau,
      'phoneNumber': instance.phoneNumber,
      'cin': instance.cin,
      'club': instance.club?.toJson(),
    };
