// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Club.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Club _$ClubFromJson(Map<String, dynamic> json) => Club(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      abbreviation: json['abbreviation'] as String?,
      logo: json['logo'] as String?,
      cover: json['cover'] as String?,
      maillot: json['maillot'] as String?,
      short: json['short'] as String?,
      bas: json['bas'] as String?,
      league: (json['league'] as num?)?.toInt(),
      responsible_email: json['responsible_email'] as String?,
      responsible_name: json['responsible_name'] as String?,
      order_main_page: (json['order_main_page'] as num?)?.toInt(),
      order: (json['order'] as num?)?.toInt(),
      active: json['active'] as bool?,
      send_mail: json['send_mail'] as bool?,
    );

Map<String, dynamic> _$ClubToJson(Club instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'abbreviation': instance.abbreviation,
      'logo': instance.logo,
      'cover': instance.cover,
      'maillot': instance.maillot,
      'short': instance.short,
      'bas': instance.bas,
      'league': instance.league,
      'responsible_email': instance.responsible_email,
      'responsible_name': instance.responsible_name,
      'order_main_page': instance.order_main_page,
      'order': instance.order,
      'active': instance.active,
      'send_mail': instance.send_mail,
    };
