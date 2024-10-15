// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Coupe8.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupe8 _$Coupe8FromJson(Map<String, dynamic> json) => Coupe8(
      name: json['name'] as String?,
      season: json['season'] == null
          ? null
          : Season.fromJson(json['season'] as Map<String, dynamic>),
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
      finalMatch: json['finalMatch'] == null
          ? null
          : Match.fromJson(json['finalMatch'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$Coupe8ToJson(Coupe8 instance) => <String, dynamic>{
      'name': instance.name,
      'season': instance.season?.toJson(),
      'quarter_final_1': instance.quarter_final_1?.toJson(),
      'quarter_final_2': instance.quarter_final_2?.toJson(),
      'quarter_final_3': instance.quarter_final_3?.toJson(),
      'quarter_final_4': instance.quarter_final_4?.toJson(),
      'semi_final_1': instance.semi_final_1?.toJson(),
      'semi_final_2': instance.semi_final_2?.toJson(),
      'finalMatch': instance.finalMatch?.toJson(),
    };
