// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SuperPlayOff8.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperPlayOff8 _$SuperPlayOff8FromJson(Map<String, dynamic> json) =>
    SuperPlayOff8(
      id: (json['id'] as num).toInt(),
      semi_final_1_Home: json['semi_final_1_Home'] == null
          ? null
          : Match.fromJson(json['semi_final_1_Home'] as Map<String, dynamic>),
      semi_final_1_Away: json['semi_final_1_Away'] == null
          ? null
          : Match.fromJson(json['semi_final_1_Away'] as Map<String, dynamic>),
      semi_final_2_Home: json['semi_final_2_Home'] == null
          ? null
          : Match.fromJson(json['semi_final_2_Home'] as Map<String, dynamic>),
      semi_final_2_Away: json['semi_final_2_Away'] == null
          ? null
          : Match.fromJson(json['semi_final_2_Away'] as Map<String, dynamic>),
      finalMatch: json['finalMatch'] == null
          ? null
          : Match.fromJson(json['finalMatch'] as Map<String, dynamic>),
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
