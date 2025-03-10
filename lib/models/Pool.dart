import 'package:json_annotation/json_annotation.dart';
import 'PremierePhase.dart'; // Assuming PremierePhase model is defined
import 'Club.dart'; // Assuming Club model is defined

part 'Pool.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class Pool {
  final int? id;
  final int? premiere_phase;
  final List<int>? teams;
  final bool? create_matches;
  final String? type;
  final String? name;
  final String? full_name;

  Pool({
    required this.id,
    required this.premiere_phase,
    required this.teams,
    required this.create_matches,
    required this.type,
    required this.name,
    required this.full_name
  });

  // JSON serialization methods
  factory Pool.fromJson(Map<String, dynamic> json) => _$PoolFromJson(json);
  Map<String, dynamic> toJson() => _$PoolToJson(this);
}
