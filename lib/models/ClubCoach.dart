import 'package:json_annotation/json_annotation.dart';
import 'Club.dart';

part 'ClubCoach.g.dart'; // Make sure this matches your filename

@JsonSerializable()
class ClubCoach {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final DateTime birthday;
  final String? cin;
  final String? cinImage;
  final String? email;
  final String? phoneNumber;
  final Club? club;

  ClubCoach({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.birthday,
    required this.cin,
    required this.cinImage,
    required this.email,
    required this.phoneNumber,
    required this.club,
  });

  factory ClubCoach.fromJson(Map<String, dynamic> json) => _$ClubCoachFromJson(json);
  Map<String, dynamic> toJson() => _$ClubCoachToJson(this);
}
