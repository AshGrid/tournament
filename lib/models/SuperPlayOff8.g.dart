// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SuperPlayOff8.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperPlayOff8 _$SuperPlayOff8FromJson(Map<String, dynamic> json) =>
    SuperPlayOff8(
      id: (json['id'] as num).toInt(),
      semi_final_1_Home: json['semi_final_1_home'] == null
          ? null
          : Match.fromJson(json['semi_final_1_home'] as Map<String, dynamic>),
       season: json['season'] == null
           ? null
           : Season.fromJson(json['season'] as Map<String, dynamic>),
      semi_final_1_Away: json['semi_final_1_away'] == null
          ? null
          : Match.fromJson(json['semi_final_1_away'] as Map<String, dynamic>),
      semi_final_2_Home: json['semi_final_2_home'] == null
          ? null
          : Match.fromJson(json['semi_final_2_home'] as Map<String, dynamic>),
      semi_final_2_Away: json['semi_final_2_away'] == null
          ? null
          : Match.fromJson(json['semi_final_2_away'] as Map<String, dynamic>),
      finalMatch: json['final'] == null
          ? null
          : Match.fromJson(json['final'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SuperPlayOff8ToJson(SuperPlayOff8 instance) =>
    <String, dynamic>{
      'id': instance.id,
      'semi_final_1_Home': instance.semi_final_1_Home,
      'semi_final_1_Away': instance.semi_final_1_Away,
      'semi_final_2_Home': instance.semi_final_2_Home,
      'semi_final_2_Away': instance.semi_final_2_Away,
      'finalMatch': instance.finalMatch,
    };
