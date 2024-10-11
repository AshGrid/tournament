import 'package:json_annotation/json_annotation.dart';
import 'PremierePhase.dart'; // Assuming PremierePhase model is defined
import 'Club.dart'; // Assuming Club model is defined

part 'Pool.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class Pool {
  final int? id;
  final PremierePhase? premierePhase;
  final List<Club>? teams;
  final bool? createMatches;
  final String? type;

  Pool({
    required this.id,
    required this.premierePhase,
    required this.teams,
    required this.createMatches,
    required this.type,
  });

  // JSON serialization methods
  factory Pool.fromJson(Map<String, dynamic> json) => _$PoolFromJson(json);
  Map<String, dynamic> toJson() => _$PoolToJson(this);
}
