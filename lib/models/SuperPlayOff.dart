import 'package:json_annotation/json_annotation.dart';
import 'Match.dart';
part 'SuperPlayOff.g.dart'; // Name of the generated file

@JsonSerializable()
class SuperPlayOff {
  final int id;
  Match? quarter_final_1_home;
  Match? quarter_final_1_away;
  Match? quarter_final_2_home;
  Match? quarter_final_2_away; // Fixed naming convention
  Match? quarter_final_3_home;
  Match? quarter_final_3_away;
  Match? quarter_final_4_home;
  Match? quarter_final_4_away;
  Match? semi_final_1_home;
  Match? semi_final_1_away;
  Match? semi_final_2_home;
  Match? semi_final_2_away;
  Match? finalmatch; // Renamed finalMatch to final_match

  SuperPlayOff({
    required this.id,
    this.quarter_final_1_home,
    this.quarter_final_1_away,
    this.quarter_final_2_home,
    this.quarter_final_2_away,
    this.quarter_final_3_home,
    this.quarter_final_3_away,
    this.quarter_final_4_home,
    this.quarter_final_4_away,
    this.semi_final_1_home,
    this.semi_final_1_away,
    this.semi_final_2_home,
    this.semi_final_2_away,
    this.finalmatch, // Updated constructor parameter name
  });

  factory SuperPlayOff.fromJson(Map<String, dynamic> json) => _$SuperPlayOffFromJson(json);
  Map<String, dynamic> toJson() => _$SuperPlayOffToJson(this);
}
