// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      id: (json['id'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      position: json['position'] as String?,
      nationality: json['nationality'] as String?,
      number: json['number'] as String?,
      avatar: json['avatar'] as String?,
      cin_image: json['cin_image'] as String?,
      cin: json['cin'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      attestation: json['attestation'] as String?,
      medical_certificate: json['medical_certificate'] as String?,
      taille: json['taille'] as String?,
      club: (json['club'] as num?)?.toInt(),
      captain: json['captain'] as bool?,
      verified: json['verified'] as bool?,
      decline_reason: json['decline_reason'] as String?,
      pending_verification: json['pending_verification'] as bool?,
      suspended: json['suspended'] as bool?,
      suspension_duration: (json['suspension_duration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'position': instance.position,
      'nationality': instance.nationality,
      'number': instance.number,
      'avatar': instance.avatar,
      'cin_image': instance.cin_image,
      'cin': instance.cin,
      'birthday': instance.birthday?.toIso8601String(),
      'attestation': instance.attestation,
      'medical_certificate': instance.medical_certificate,
      'taille': instance.taille,
      'club': instance.club,
      'captain': instance.captain,
      'verified': instance.verified,
      'decline_reason': instance.decline_reason,
      'pending_verification': instance.pending_verification,
      'suspended': instance.suspended,
      'suspension_duration': instance.suspension_duration,
    };
