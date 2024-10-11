import 'package:json_annotation/json_annotation.dart';

part 'Arbitre.g.dart';

@JsonSerializable()
class Arbitre {
  final int? id;
  final String? name;

  Arbitre({
    required this.id,
    required this.name,
  });

  // JSON serialization methods
  factory Arbitre.fromJson(Map<String, dynamic> json) => _$ArbitreFromJson(json);
  Map<String, dynamic> toJson() => _$ArbitreToJson(this);
}