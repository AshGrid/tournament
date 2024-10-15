// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Coupe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupe _$CoupeFromJson(Map<String, dynamic> json) => Coupe(
      name: json['name'] as String?,
      season: json['season'] == null
          ? null
          : Season.fromJson(json['season'] as Map<String, dynamic>),
      round_1: json['round_1'] == null
          ? null
          : Match.fromJson(json['round_1'] as Map<String, dynamic>),
      round_2: json['round_2'] == null
          ? null
          : Match.fromJson(json['round_2'] as Map<String, dynamic>),
      round_3: json['round_3'] == null
          ? null
          : Match.fromJson(json['round_3'] as Map<String, dynamic>),
      round_4: json['round_4'] == null
          ? null
          : Match.fromJson(json['round_4'] as Map<String, dynamic>),
      round_5: json['round_5'] == null
          ? null
          : Match.fromJson(json['round_5'] as Map<String, dynamic>),
      round_6: json['round_6'] == null
          ? null
          : Match.fromJson(json['round_6'] as Map<String, dynamic>),
      round_7: json['round_7'] == null
          ? null
          : Match.fromJson(json['round_7'] as Map<String, dynamic>),
      round_8: json['round_8'] == null
          ? null
          : Match.fromJson(json['round_8'] as Map<String, dynamic>),
      quarter_final_1: json['quarter_final_1'] == null
          ? null
          : Match.fromJson(json['quarter_final_1'] as Map<String, dynamic>),
      quarter_final_2: json['quarter_final_2'] == null
          ? null
          : Match.fromJson(json['quarter_final_2'] as Map<String, dynamic>),
      quarter_final_3: json['quarter_final_3'] == null
          ? null
          : Match.fromJson(json['quarter_final_3'] as Map<String, dynamic>),
      quarter_final_4: json['quarter_final_4'] == null
          ? null
          : Match.fromJson(json['quarter_final_4'] as Map<String, dynamic>),
      semi_final_1: json['semi_final_1'] == null
          ? null
          : Match.fromJson(json['semi_final_1'] as Map<String, dynamic>),
      semi_final_2: json['semi_final_2'] == null
          ? null
          : Match.fromJson(json['semi_final_2'] as Map<String, dynamic>),
      finalmatch: json['finalmatch'] == null
          ? null
          : Match.fromJson(json['final'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CoupeToJson(Coupe instance) => <String, dynamic>{
      'name': instance.name,
      'season': instance.season?.toJson(),
      'round_1': instance.round_1?.toJson(),
      'round_2': instance.round_2?.toJson(),
      'round_3': instance.round_3?.toJson(),
      'round_4': instance.round_4?.toJson(),
      'round_5': instance.round_5?.toJson(),
      'round_6': instance.round_6?.toJson(),
      'round_7': instance.round_7?.toJson(),
      'round_8': instance.round_8?.toJson(),
      'quarter_final_1': instance.quarter_final_1?.toJson(),
      'quarter_final_2': instance.quarter_final_2?.toJson(),
      'quarter_final_3': instance.quarter_final_3?.toJson(),
      'quarter_final_4': instance.quarter_final_4?.toJson(),
      'semi_final_1': instance.semi_final_1?.toJson(),
      'semi_final_2': instance.semi_final_2?.toJson(),
      'final': instance.finalmatch?.toJson(),
    };
