// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SuperPlayOff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperPlayOff _$SuperPlayOffFromJson(Map<String, dynamic> json) => SuperPlayOff(
      id: (json['id'] as num).toInt(),
      quarter_final_1_home: json['quarter_final_1_home'] == null
          ? null
          : Match.fromJson(
              json['quarter_final_1_home'] as Map<String, dynamic>),
      quarter_final_1_away: json['quarter_final_1_away'] == null
          ? null
          : Match.fromJson(
              json['quarter_final_1_away'] as Map<String, dynamic>),
      quarter_final_2_home: json['quarter_final_2_home'] == null
          ? null
          : Match.fromJson(
              json['quarter_final_2_home'] as Map<String, dynamic>),
      quarter_final_2_away: json['quarter_final_2_away'] == null
          ? null
          : Match.fromJson(
              json['quarter_final_2_away'] as Map<String, dynamic>),
      quarter_final_3_home: json['quarter_final_3_home'] == null
          ? null
          : Match.fromJson(
              json['quarter_final_3_home'] as Map<String, dynamic>),
      quarter_final_3_away: json['quarter_final_3_away'] == null
          ? null
          : Match.fromJson(
              json['quarter_final_3_away'] as Map<String, dynamic>),
      quarter_final_4_home: json['quarter_final_4_home'] == null
          ? null
          : Match.fromJson(
              json['quarter_final_4_home'] as Map<String, dynamic>),
      quarter_final_4_away: json['quarter_final_4_away'] == null
          ? null
          : Match.fromJson(
              json['quarter_final_4_away'] as Map<String, dynamic>),
      semi_final_1_home: json['semi_final_1_home'] == null
          ? null
          : Match.fromJson(json['semi_final_1_home'] as Map<String, dynamic>),
      semi_final_1_away: json['semi_final_1_away'] == null
          ? null
          : Match.fromJson(json['semi_final_1_away'] as Map<String, dynamic>),
      semi_final_2_home: json['semi_final_2_home'] == null
          ? null
          : Match.fromJson(json['semi_final_2_home'] as Map<String, dynamic>),
      semi_final_2_away: json['semi_final_2_away'] == null
          ? null
          : Match.fromJson(json['semi_final_2_away'] as Map<String, dynamic>),
      finalmatch: json['finalmatch'] == null
          ? null
          : Match.fromJson(json['finalmatch'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SuperPlayOffToJson(SuperPlayOff instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quarter_final_1_home': instance.quarter_final_1_home,
      'quarter_final_1_away': instance.quarter_final_1_away,
      'quarter_final_2_home': instance.quarter_final_2_home,
      'quarter_final_2_away': instance.quarter_final_2_away,
      'quarter_final_3_home': instance.quarter_final_3_home,
      'quarter_final_3_away': instance.quarter_final_3_away,
      'quarter_final_4_home': instance.quarter_final_4_home,
      'quarter_final_4_away': instance.quarter_final_4_away,
      'semi_final_1_home': instance.semi_final_1_home,
      'semi_final_1_away': instance.semi_final_1_away,
      'semi_final_2_home': instance.semi_final_2_home,
      'semi_final_2_away': instance.semi_final_2_away,
      'finalmatch': instance.finalmatch,
    };
