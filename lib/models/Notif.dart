import 'package:json_annotation/json_annotation.dart';

part 'Notif.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class Notif {
  final String title;
  final String image;
  final String description;

  Notif({
    required this.title,
    required this.image,
    required this.description,
  });

  // JSON serialization methods
  factory Notif.fromJson(Map<String, dynamic> json) => _$NotifFromJson(json);
  Map<String, dynamic> toJson() => _$NotifToJson(this);
}
