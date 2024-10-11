// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      position: json['position'] as String?,
      nationality: json['nationality'] as String?,
      number: json['number'] as String?,
      avatar: json['avatar'] as String?,
      cinImage: json['cinImage'] as String?,
      cin: json['cin'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      attestation: json['attestation'] as String?,
      medicalCertificate: json['medicalCertificate'] as String?,
      taille: json['taille'] as String?,
      club: json['club'] == null
          ? null
          : Club.fromJson(json['club'] as Map<String, dynamic>),
      captain: json['captain'] as bool?,
      verified: json['verified'] as bool?,
      declineReason: json['declineReason'] as String?,
      pendingVerification: json['pendingVerification'] as bool?,
      suspended: json['suspended'] as bool?,
      suspensionDuration: (json['suspensionDuration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'position': instance.position,
      'nationality': instance.nationality,
      'number': instance.number,
      'avatar': instance.avatar,
      'cinImage': instance.cinImage,
      'cin': instance.cin,
      'birthday': instance.birthday?.toIso8601String(),
      'attestation': instance.attestation,
      'medicalCertificate': instance.medicalCertificate,
      'taille': instance.taille,
      'club': instance.club,
      'captain': instance.captain,
      'verified': instance.verified,
      'declineReason': instance.declineReason,
      'pendingVerification': instance.pendingVerification,
      'suspended': instance.suspended,
      'suspensionDuration': instance.suspensionDuration,
    };
