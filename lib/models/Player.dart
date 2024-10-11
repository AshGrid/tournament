import 'package:json_annotation/json_annotation.dart';
import 'Club.dart'; // Import your Club model

part 'Player.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class Player {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? position;
  final String? nationality;
  final String? number;
  final String? avatar;
  final String? cinImage;
  final String? cin;
  final DateTime? birthday;
  final String? attestation;
  final String? medicalCertificate;
  final String? taille;
  final Club? club; // Ensure Club is serializable
  final bool? captain;
  final bool? verified;
  final String? declineReason;
  final bool? pendingVerification;
  final bool? suspended;
  final int? suspensionDuration;

  Player({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.nationality,
    required this.number,
    required this.avatar,
    required this.cinImage,
    required this.cin,
    required this.birthday,
    required this.attestation,
    required this.medicalCertificate,
    required this.taille,
    required this.club,
    required this.captain,
    required this.verified,
    required this.declineReason,
    required this.pendingVerification,
    required this.suspended,
    required this.suspensionDuration,
  });

  // JSON serialization methods
  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
