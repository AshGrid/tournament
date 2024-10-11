import 'package:json_annotation/json_annotation.dart';

part 'Venue.g.dart'; // Name of the generated file

@JsonSerializable() // Enable JSON serialization
class Venue {
  final int? id;
  final String? name;
  final String? address;

  Venue({
    required this.id,
    required this.name,
    required this.address,
  });

  // JSON serialization methods
  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);
  Map<String, dynamic> toJson() => _$VenueToJson(this);
}
