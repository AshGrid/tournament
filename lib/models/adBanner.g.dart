// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adBanner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

adBanner _$adBannerFromJson(Map<String, dynamic> json) => adBanner(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      image: json['image'] as String?,
      place: json['place'] as String?,
    );

Map<String, dynamic> _$adBannerToJson(adBanner instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'place': instance.place,
    };
