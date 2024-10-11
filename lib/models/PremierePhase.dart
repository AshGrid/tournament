import 'package:json_annotation/json_annotation.dart';
import 'Season.dart'; // Assuming Season model is defined

part 'PremierePhase.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class PremierePhase {
  final int? id;
  final Season? season;
  final String? type;
  final bool? createPool;
  final bool? createMatch;
  final bool? automaticJourney;

  PremierePhase({
    required this.id,
    required this.season,
    required this.type,
    required this.createPool,
    required this.createMatch,
    required this.automaticJourney,
  });

  // JSON serialization methods
  factory PremierePhase.fromJson(Map<String, dynamic> json) => _$PremierePhaseFromJson(json);
  Map<String, dynamic> toJson() => _$PremierePhaseToJson(this);
}
