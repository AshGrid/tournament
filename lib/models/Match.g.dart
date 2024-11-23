// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Match _$MatchFromJson(Map<String, dynamic> json) => Match(
      id: (json['id'] as num?)?.toInt(),
      home: json['home'] == null
          ? null
          : Club.fromJson(json['home'] as Map<String, dynamic>),
      away: json['away'] == null
          ? null
          : Club.fromJson(json['away'] as Map<String, dynamic>),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      venue: json['venue'] == null
          ? null
          : Venue.fromJson(json['venue'] as Map<String, dynamic>),
      arbitres: (json['arbitres'] as List<dynamic>?)
          ?.map((e) => Arbitre.fromJson(e as Map<String, dynamic>))
          .toList(),
      supervisors: json['supervisors'] == null
          ? null
          : Supervisor.fromJson(json['supervisors'] as Map<String, dynamic>),
      home_first_half_score: (json['home_first_half_score'] as num?)?.toInt(),
      away_first_half_score: (json['away_first_half_score'] as num?)?.toInt(),
      home_second_half_score: (json['home_second_half_score'] as num?)?.toInt(),
      away_second_half_score: (json['away_second_half_score'] as num?)?.toInt(),
      status: json['status'] as String?,
      is_ended: json['is_ended'] as bool?,
      trophy: json['trophy'] == null
          ? null
          : Trophy.fromJson(json['trophy'] as Map<String, dynamic>),
      season: (json['season'] as num?)?.toInt(),
      premiere_phase: (json['premiere_phase'] as num?)?.toInt(),
      is_premiere_phase: json['is_premiere_phase'] as bool?,
      is_playoff: json['is_playoff'] as bool?,
      is_trophy: json['is_trophy'] as bool?,
      is_super_trophy: json['is_super_trophy'] as bool?,
      is_super_playoff: json['is_super_playoff'] as bool?,
      is_coupe: json['is_coupe'] as bool?,
      is_super_coupe: json['is_super_coupe'] as bool?,
      journey: json['journey'] == null
          ? null
          : Journey.fromJson(json['journey'] as Map<String, dynamic>),
      time: json['time'] as String?,
    );

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
      'id': instance.id,
      'home': instance.home?.toJson(),
      'away': instance.away?.toJson(),
      'date': instance.date?.toIso8601String(),
      'venue': instance.venue?.toJson(),
      'arbitres': instance.arbitres?.map((e) => e.toJson()).toList(),
      'supervisors': instance.supervisors?.toJson(),
      'home_first_half_score': instance.home_first_half_score,
      'away_first_half_score': instance.away_first_half_score,
      'home_second_half_score': instance.home_second_half_score,
      'away_second_half_score': instance.away_second_half_score,
      'status': instance.status,
      'is_ended': instance.is_ended,
      'trophy': instance.trophy?.toJson(),
      'season': instance.season,
      'premiere_phase': instance.premiere_phase,
      'is_premiere_phase': instance.is_premiere_phase,
      'is_playoff': instance.is_playoff,
      'is_trophy': instance.is_trophy,
      'is_super_trophy': instance.is_super_trophy,
      'is_super_playoff': instance.is_super_playoff,
      'is_coupe': instance.is_coupe,
      'is_super_coupe': instance.is_super_coupe,
      'journey': instance.journey?.toJson(),
      'time': instance.time,
    };
