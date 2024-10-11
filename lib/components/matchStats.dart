import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';

import 'colors.dart';
import '../models/Match.dart';

class MatchStats extends StatelessWidget {
  // List of events
  final Match match;

  const MatchStats({Key? key, required this.match}) : super(key: key);








  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),

    );
  }
}
