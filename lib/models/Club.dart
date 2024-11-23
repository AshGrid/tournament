import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';


import 'League.dart'; // Import the LeagueFocus model

part 'Club.g.dart';

@JsonSerializable(explicitToJson: true)
class Club {
  final int? id;
  final String name;
  final String? abbreviation;
  final String? logo;
  final String? cover;
  final String? maillot;
  final String? short;
  final String? bas;
  final int? league; // Replace int with LeagueFocus
  final String? responsible_email;
  final String? responsible_name;
  final int? order_main_page;
  final int? order;
  final bool? active;
  final bool? send_mail;

  Club({
    required this.id,
    required this.name,
    required this.abbreviation,
     this.logo,
     this.cover,
    required this.maillot,
    required this.short,
    required this.bas,
    required this.league,
    required this.responsible_email,
    required this.responsible_name,
    required this.order_main_page,
    required this.order,
    required this.active,
    required this.send_mail,

  }); // Set default value for logo

  factory Club.fromJson(Map<String, dynamic> json) => _$ClubFromJson(json);
  Map<String, dynamic> toJson() => _$ClubToJson(this);

}