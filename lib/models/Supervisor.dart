import 'package:json_annotation/json_annotation.dart';
import 'User.dart'; // Assuming User model is defined

part 'Supervisor.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class Supervisor {
  final int? id;
  final User? user;
  final String? name;

  Supervisor({
    required this.id,
    required this.user,
    required this.name,
  });

  // JSON serialization methods
  factory Supervisor.fromJson(Map<String, dynamic> json) => _$SupervisorFromJson(json);
  Map<String, dynamic> toJson() => _$SupervisorToJson(this);
}
