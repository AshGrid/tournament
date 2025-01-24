import 'package:json_annotation/json_annotation.dart';

part 'Moment.g.dart'; // Replace with your actual file name

@JsonSerializable()
class Moment {
  final int id;
  final String video;
  final String name;
  final DateTime created_at;

  Moment({
    required this.id,
    required this.video,
    required this.name,
    required this.created_at,
  });

  // Factory method to create an instance from JSON
  factory Moment.fromJson(Map<String, dynamic> json) => _$MomentFromJson(json);

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() => _$MomentToJson(this);
}
