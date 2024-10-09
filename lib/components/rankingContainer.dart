import 'package:flutter/material.dart';
import 'package:untitled/components/TeamItem.dart';
import 'package:untitled/components/colors.dart';

import '../models/Team.dart';
import 'image_slider.dart';

class PremierePhaseRankingScreen extends StatelessWidget {
  final List<String> imagePath = [
    'assets/images/image1.jpeg',
    'assets/images/image2.jpeg',
    'assets/images/image1.jpeg',
  ];
  final List<Team> mockTeams = [
    Team(rank: 1, name: "Monoprix", matchesPlayed: 5, goals: 10, points: 15, logo: "assets/images/ennakl.jpg"),
    Team(rank: 2, name: "Team B", matchesPlayed: 4, goals: 8, points: 12, logo: "assets/images/ennakl.jpg"),
    Team(rank: 3, name: "Team C", matchesPlayed: 6, goals: 5, points: 9, logo: "assets/images/ennakl.jpg"),
    Team(rank: 4, name: "Team D", matchesPlayed: 5, goals: 6, points: 8, logo: "assets/images/ennakl.jpg"),
    Team(rank: 5, name: "Team E", matchesPlayed: 5, goals: 7, points: 8, logo: "assets/images/ennakl.jpg"),
    Team(rank: 6, name: "Team F", matchesPlayed: 5, goals: 4, points: 7, logo: "assets/images/ennakl.jpg"),
    Team(rank: 7, name: "Team G", matchesPlayed: 5, goals: 3, points: 6, logo: "assets/images/ennakl.jpg"),
    Team(rank: 8, name: "Team H", matchesPlayed: 5, goals: 2, points: 5, logo: "assets/images/ennakl.jpg"),
    Team(rank: 9, name: "Team I", matchesPlayed: 5, goals: 1, points: 4, logo: "assets/images/ennakl.jpg"),
    Team(rank: 10, name: "Team J", matchesPlayed: 5, goals: 0, points: 3, logo: "assets/images/ennakl.jpg"),
    Team(rank: 11, name: "Team K", matchesPlayed: 5, goals: 2, points: 2, logo: "assets/images/ennakl.jpg"),
    Team(rank: 12, name: "Team L", matchesPlayed: 5, goals: 3, points: 1, logo: "assets/images/ennakl.jpg"),
    Team(rank: 13, name: "Team M", matchesPlayed: 5, goals: 4, points: 0, logo: "assets/images/ennakl.jpg"),
    Team(rank: 14, name: "Team N", matchesPlayed: 5, goals: 2, points: 0, logo: "assets/images/ennakl.jpg"),
    Team(rank: 15, name: "Team O", matchesPlayed: 5, goals: 1, points: 0, logo: "assets/images/ennakl.jpg"),
    Team(rank: 16, name: "Team P", matchesPlayed: 5, goals: 0, points: 0, logo: "assets/images/ennakl.jpg"),
    // Add more teams here...
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
                      SizedBox(width: 140,child: Text('EQUIPE', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold))),
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
                      children: mockTeams.asMap().entries.map((entry) {
                        int index = entry.key;
                        Team team = entry.value;

                         // Set color based on rank
                         // Text color inside the box

                        return TeamItem(team: team,index:index);
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

// Mock Team model

