import 'package:json_annotation/json_annotation.dart';
import 'Pool.dart'; // Import the Pool model

part 'Journey.g.dart';

@JsonSerializable(explicitToJson: true) // Enable explicit to JSON serialization for nested objects
class Journey {
  final int? id;
  final int? pool; // Assuming Pool is also JSON serializable
  final int? number;

  Journey({
    required this.id,
    required this.pool,
    required this.number,
  });

  // JSON serialization methods
  factory Journey.fromJson(Map<String, dynamic> json) => _$JourneyFromJson(json);
  Map<String, dynamic> toJson() => _$JourneyToJson(this);
}
