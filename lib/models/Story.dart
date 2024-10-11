import 'package:json_annotation/json_annotation.dart';

part 'Story.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class Story {
  final int id;
  final String name;
  final String file;

  Story({
    required this.id,
    required this.name,
    required this.file,
  });

  // JSON serialization methods
  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
  Map<String, dynamic> toJson() => _$StoryToJson(this);
}
