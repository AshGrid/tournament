import 'package:json_annotation/json_annotation.dart';
import 'Club.dart'; // Import your Club model

part 'Player.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class Player {
  final int? id;
  final String? first_name;
  final String? last_name;
  final String? position;
  final String? nationality;
  final String? number;
  final String? avatar;
  final String? cin_image;
  final String? cin;
  final DateTime? birthday;
  final String? attestation;
  final String? medical_certificate;
  final String? taille;
  final int? club; // Ensure Club is serializable
  final bool? captain;
  final bool? verified;
  final String? decline_reason;
  final bool? pending_verification;
  final bool? suspended;
  final int? suspension_duration;

  Player({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.position,
    required this.nationality,
    required this.number,
    required this.avatar,
    required this.cin_image,
    required this.cin,
    required this.birthday,
    required this.attestation,
    required this.medical_certificate,
    required this.taille,
    required this.club,
    required this.captain,
    required this.verified,
    required this.decline_reason,
    required this.pending_verification,
    required this.suspended,
    required this.suspension_duration,
  });

  // JSON serialization methods
  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
