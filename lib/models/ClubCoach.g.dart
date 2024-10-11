// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ClubCoach.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubCoach _$ClubCoachFromJson(Map<String, dynamic> json) => ClubCoach(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      avatar: json['avatar'] as String?,
      birthday: DateTime.parse(json['birthday'] as String),
      cin: json['cin'] as String?,
      cinImage: json['cinImage'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      club: json['club'] == null
          ? null
          : Club.fromJson(json['club'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClubCoachToJson(ClubCoach instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatar': instance.avatar,
      'birthday': instance.birthday.toIso8601String(),
      'cin': instance.cin,
      'cinImage': instance.cinImage,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'club': instance.club,
    };
