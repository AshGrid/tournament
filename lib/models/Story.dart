import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'Video.dart';
part 'Story.g.dart'; // Name of the generated file


@JsonSerializable() // Enable JSON serialization
class Story {
  final int id;
  final String? name;

  final List <Video>? videos;

  Story( {
    required this.videos,
    required this.id,
    required this.name,

  });

  // JSON serialization methods
  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
  Map<String, dynamic> toJson() => _$StoryToJson(this);



}
