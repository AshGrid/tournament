import 'package:flutter/material.dart';
import 'package:untitled/components/TeamItem.dart';
import 'package:untitled/components/colors.dart';
import 'package:untitled/models/Club.dart';
import '../models/Team.dart';
import '../models/TeamRanking.dart';
import 'image_slider.dart';

class PremierePhaseRankingScreen extends StatefulWidget {
  final List<TeamRanking> clubs;

  // Constructor that accepts parameters
  PremierePhaseRankingScreen({
    required this.clubs,
  });

  @override
  _PremierePhaseRankingScreenState createState() => _PremierePhaseRankingScreenState();
}




class _PremierePhaseRankingScreenState extends State<PremierePhaseRankingScreen> {


  @override
  void initState() {
    super.initState();
print("clubsranking:${widget.clubs}");

  }

  final List<String> imagePath = [
    'assets/images/image1.jpeg',
    'assets/images/image2.jpeg',
    'assets/images/image1.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 40, child: Text('#', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                      SizedBox(width: 140, child: Text('EQUIPE', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(width: 60, child: Text('MJ', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(width: 60, child: Text('B', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(width: 60, child: Text('PTS', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                Divider(), // Add a divider for better visual separation

                // Container with fixed height for scrolling
                Container(
                  height: 500, // Set a fixed height to show only 8 teams
                  child: SingleChildScrollView(
                    child: Column(
                      children: widget.clubs.asMap().entries.map((entry) {
                        int index = entry.key;
                        TeamRanking club = entry.value;

                        // Set color based on rank
                        // Text color inside the box

                        return TeamItem(club: club.club!, index: index,ranking : club);
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: ImageSlider(
              imagePaths: imagePath,
            ),
          ),
        ],
      ),
    );
  }
}
