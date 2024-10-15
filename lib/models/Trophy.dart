import 'package:json_annotation/json_annotation.dart';

part 'Trophy.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class Trophy {
  final int? id;
  final String? name;
  final String? image;
  final DateTime? date;
  final bool? active;

  Trophy({
    required this.id,
    required this.name,
    required this.image,
    required this.date,
    required this.active
  });

  // JSON serialization methods
  factory Trophy.fromJson(Map<String, dynamic> json) => _$TrophyFromJson(json);
  Map<String, dynamic> toJson() => _$TrophyToJson(this);
}
