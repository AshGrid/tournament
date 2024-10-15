

import 'package:json_annotation/json_annotation.dart';
import 'Season.dart';
import 'Match.dart';


part 'Coupe.g.dart';
@JsonSerializable(explicitToJson: true)
class Coupe {
  String? name;
  Season? season;
  Match? round_1;
  Match? round_2;
  Match? round_3;
  Match? round_4;
  Match? round_5;
  Match? round_6;
  Match? round_7;
  Match? round_8;
  Match? quarter_final_1;
  Match? quarter_final_2;
  Match? quarter_final_3;
  Match? quarter_final_4;
  Match? semi_final_1;
  Match? semi_final_2;
  Match? finalmatch;

  Coupe({
    this.name,
    this.season,
    this.round_1,
    this.round_2,
    this.round_3,
    this.round_4,
    this.round_5,
    this.round_6,
    this.round_7,
    this.round_8,
    this.quarter_final_1,
    this.quarter_final_2,
    this.quarter_final_3,
    this.quarter_final_4,
    this.semi_final_1,
    this.semi_final_2,
    this.finalmatch,
  });

  // Factory method to parse JSON into Coupe object
  factory Coupe.fromJson(Map<String, dynamic> json) => _$CoupeFromJson(json);
  Map<String, dynamic> toJson() => _$CoupeToJson(this);

  // Method to convert Coupe object to JSON

}
