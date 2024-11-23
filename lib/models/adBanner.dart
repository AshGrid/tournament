import 'package:json_annotation/json_annotation.dart';

part 'adBanner.g.dart';

@JsonSerializable()
class adBanner {
  final int? id;
  final String? name;
  final String? image;
  final String? place;

  adBanner({
    required this.id,
    required this.name,
    required this.image,
    required this.place,
  });

  // JSON serialization methods
  factory adBanner.fromJson(Map<String, dynamic> json) => _$adBannerFromJson(json);
  Map<String, dynamic> toJson() => _$adBannerToJson(this);
}