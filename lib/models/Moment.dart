import 'package:json_annotation/json_annotation.dart';

part 'Moment.g.dart';

@JsonSerializable() // Enable JSON serialization
class Moment {
  final int id;
  final String? name; // Nullable name
  final String? file; // Nullable file

  Moment({
    required this.id,
    this.name,
    this.file,
  });

  // JSON serialization methods
  factory Moment.fromJson(Map<String, dynamic> json) => _$MomentFromJson(json);
  Map<String, dynamic> toJson() => _$MomentToJson(this);
}
