

import 'package:json_annotation/json_annotation.dart';

part 'Video.g.dart'; // Name of the generated file






@JsonSerializable() // Enable JSON serializati
class Video {
  final int id;
  final String? lien;
  final int order;
 final int story;


  Video({
    required this.id,
    required this.lien,
    required this.order,
    required this.story,

  });

  // JSON serialization methods
  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
