import 'package:json_annotation/json_annotation.dart';
import 'Match.dart';
import 'Season.dart';
part 'SuperPlayOff8.g.dart'; // Name of the generated file

@JsonSerializable()
class SuperPlayOff8 {
  final int id;

  Season? season;

  Match? semi_final_1_Home;
  Match? semi_final_1_Away;
  Match? semi_final_2_Home;
  Match? semi_final_2_Away;
  Match? finalMatch;


  SuperPlayOff8({
    required this.id,
required this.season,
    required this.semi_final_1_Home,
    required this.semi_final_1_Away,
    required this.semi_final_2_Home,
    required this.semi_final_2_Away,
    required this.finalMatch,

  });
  factory SuperPlayOff8.fromJson(Map<String, dynamic> json) => _$SuperPlayOff8FromJson(json);

  get quarter_final_1_home => null;
  Map<String, dynamic> toJson() => _$SuperPlayOff8ToJson(this);

}
