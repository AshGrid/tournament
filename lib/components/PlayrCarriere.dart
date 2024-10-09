import 'package:flutter/material.dart';
import 'package:untitled/components/TeamItem.dart';
import 'package:untitled/components/colors.dart';

import '../models/Team.dart';
import '../models/Teams.dart';
import 'image_slider.dart';

class PlayrCarriere extends StatelessWidget {

  final List<Teams> mockTeams = [
    Teams(name: "monoprix",matches: 1, logo: "assets/images/ennakl.jpg", assists: 7, yellowCards: 2, redCards: 1, goals: 9, saison: "24/25"),
    Teams(name: "monoprix",matches: 1, logo: "assets/images/ennakl.jpg", assists: 7, yellowCards: 2, redCards: 1, goals: 9, saison: "24/25"),
    Teams(name: "monoprix",matches: 1, logo: "assets/images/ennakl.jpg", assists: 7, yellowCards: 2, redCards: 1, goals: 9, saison: "24/25"),
    Teams(name: "monoprix",matches: 1, logo: "assets/images/ennakl.jpg", assists: 7, yellowCards: 2, redCards: 1, goals: 9, saison: "24/25"),
    Teams(name: "monoprix",matches: 1, logo: "assets/images/ennakl.jpg", assists: 7, yellowCards: 2, redCards: 1, goals: 9, saison: "24/25"),
    Teams(name: "monoprix",matches: 1, logo: "assets/images/ennakl.jpg", assists: 7, yellowCards: 2, redCards: 1, goals: 9, saison: "24/25"),
    Teams(name: "monoprix",matches: 1, logo: "assets/images/ennakl.jpg", assists: 7, yellowCards: 2, redCards: 1, goals: 9, saison: "24/25"),
    Teams(name: "monoprix",matches: 1, logo: "assets/images/ennakl.jpg", assists: 7, yellowCards: 2, redCards: 1, goals: 9, saison: "24/25"),
    Teams(name: "monoprix",matches: 1, logo: "assets/images/ennakl.jpg", assists: 7, yellowCards: 2, redCards: 1, goals: 9, saison: "24/25"),
    Teams(name: "monoprix",matches: 1, logo: "assets/images/ennakl.jpg", assists: 7, yellowCards: 2, redCards: 1, goals: 9, saison: "24/25"),
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
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 60,),
                      SizedBox(width: 45,),
                      SizedBox(width: 80,),

                      SizedBox(width: 30, child: Text('MJ', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(width: 30, child: Text('G', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(width: 30, child: Text('A', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(width: 30, child: Text('CJ', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(width: 30, child: Text('CR', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                Divider(), // Add a divider for better visual separation

                // Container with fixed height for scrolling
                Container(

                  child: SingleChildScrollView(
                    child: Column(
                      children: mockTeams.asMap().entries.map((entry) {
                        int index = entry.key;
                        Teams team = entry.value;

                        // Set color based on rank
                        // Text color inside the box
                        Color textColor = Colors.white;
                        Color? boxColor = index < 8 ? AppColors.teamRankContainer : AppColors.teamRankContainerLast8;

                        // Fixed height for each item
                        const double itemHeight = 70.0; // Adjust height as necessary
                        return Container(
                          height: itemHeight, // Set fixed height
                          color: index.isEven ? Colors.grey[350] : Colors.white, // Alternate background colors
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                               SizedBox(
                                  width: 60,
                                  child: Text(
                                    team.saison,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10), // Rounded borders
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        width: 45, // Box width
                                        height: 45, // Box height
                                        decoration: BoxDecoration(
                                          color: Colors.white, // Background color for the box
                                          borderRadius: BorderRadius.circular(10.0), // Rounded corners
                                          border: Border.all(
                                            color: AppColors.bottomSheetLogo, // Border color
                                            width: 1.0, // Border width
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.25), // Shadow color
                                              blurRadius: 4.0, // Blur radius
                                              spreadRadius: 0.0, // Spread radius
                                              offset: const Offset(0, 4), // Shadow position
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.asset(
                                            team.logo,
                                            width: 40, // Adjust the logo size as needed
                                            height: 40,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8), // Add some space between logo and team name
                                    SizedBox(width: 80,child: Text(
                                      team.name,
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                    ),)
                                  ],
                                ),
                                SizedBox(width: 30, child: Text(team.matches.toString(), textAlign: TextAlign.right)),
                                SizedBox(width: 30, child: Text(team.goals.toString(), textAlign: TextAlign.center)),
                                SizedBox(width: 30, child: Text(team.assists.toString(), textAlign: TextAlign.center)),
                                SizedBox(width: 30, child: Text(team.assists.toString(), textAlign: TextAlign.center)),
                                SizedBox(width: 30, child: Text(team.assists.toString(), textAlign: TextAlign.center)),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

// Mock Team model

