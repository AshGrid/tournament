import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class User {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final bool? isActive;
  final bool? isStaff;
  final bool? isAdmin;
  final String? gender;
  final DateTime birthday;
  final String? phoneNumber;
  final String? address;
  final String? role;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isActive,
    required this.isStaff,
    required this.isAdmin,
    required this.gender,
    required this.birthday,
    required this.phoneNumber,
    required this.address,
    required this.role,
  });

  // JSON serialization methods
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
