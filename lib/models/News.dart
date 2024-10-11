import 'package:json_annotation/json_annotation.dart';

part 'News.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class News {
  final int id;
  final String title;
  final String image;
  final String content;
  final DateTime date;

  News({
    required this.id,
    required this.title,
    required this.image,
    required this.content,
    required this.date,
  });

  // JSON serialization methods
  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}
