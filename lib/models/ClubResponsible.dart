import 'package:json_annotation/json_annotation.dart';
import 'Club.dart'; // Import the Club model

part 'ClubResponsible.g.dart';

@JsonSerializable(explicitToJson: true) // Enable explicit to JSON serialization for nested objects
class ClubResponsible {
  final int? id;
  final String? post;
  final String? numBureau;
  final String? phoneNumber;
  final String? cin;
  final Club? club; // Club should also be JSON serializable

  ClubResponsible({
    required this.id,
    required this.post,
    required this.numBureau,
    required this.phoneNumber,
    required this.cin,
    required this.club,
  });

  // JSON serialization methods
  factory ClubResponsible.fromJson(Map<String, dynamic> json) => _$ClubResponsibleFromJson(json);
  Map<String, dynamic> toJson() => _$ClubResponsibleToJson(this);
}
