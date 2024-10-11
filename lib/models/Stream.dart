import 'package:json_annotation/json_annotation.dart';

part 'Stream.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class StreamItem {
  final int id;
  final String name;
  final String url;

  StreamItem({
    required this.id,
    required this.name,
    required this.url,
  });

  // JSON serialization methods
  factory StreamItem.fromJson(Map<String, dynamic> json) => _$StreamItemFromJson(json);
  Map<String, dynamic> toJson() => _$StreamItemToJson(this);
}
