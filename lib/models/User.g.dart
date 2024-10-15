// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      isActive: json['isActive'] as bool?,
      isStaff: json['isStaff'] as bool?,
      isAdmin: json['isAdmin'] as bool?,
      gender: json['gender'] as String?,
      birthday: DateTime.parse(json['birthday'] as String),
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'isActive': instance.isActive,
      'isStaff': instance.isStaff,
      'isAdmin': instance.isAdmin,
      'gender': instance.gender,
      'birthday': instance.birthday.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'role': instance.role,
    };
