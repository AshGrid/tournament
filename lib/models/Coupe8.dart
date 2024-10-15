import 'package:json_annotation/json_annotation.dart';

import 'Season.dart';
import 'Match.dart';



part 'Coupe8.g.dart';
@JsonSerializable(explicitToJson: true)
class Coupe8 {
  String? name;
  Season? season;
  Match? quarter_final_1;
  Match? quarter_final_2;
  Match? quarter_final_3;
  Match? quarter_final_4;
  Match? semi_final_1;
  Match? semi_final_2;
  Match? finalMatch;

  Coupe8({
    this.name,
    this.season,
    this.quarter_final_1,
    this.quarter_final_2,
    this.quarter_final_3,
    this.quarter_final_4,
    this.semi_final_1,
    this.semi_final_2,
    this.finalMatch,
  });

  // Factory method to parse JSON into Coupe8 object

  factory Coupe8.fromJson(Map<String, dynamic> json) => _$Coupe8FromJson(json);
  Map<String, dynamic> toJson() => _$Coupe8ToJson(this);
  // Method to convert Coupe8 object to JSON
}
