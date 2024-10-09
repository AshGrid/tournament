import 'package:flutter/material.dart';
import '../models/Team.dart';
import 'colors.dart'; // Adjust the path as necessary to import your Team model

class TeamItem extends StatelessWidget {
  final Team team;
  final int index;

  const TeamItem({Key? key, required this.team, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.white;
    Color? boxColor = this.index < 8 ? AppColors.teamRankContainer : AppColors.teamRankContainerLast8;

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
            Container(
              decoration: BoxDecoration(
                color: boxColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8), // Padding inside the box
              margin: EdgeInsets.only(left: 5),
              child: SizedBox(
                width: 20,
                child: Text(
                  team.rank.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor),
                ),
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
            SizedBox(width: 60, child: Text(team.matchesPlayed.toString(), textAlign: TextAlign.right)),
            SizedBox(width: 60, child: Text(team.goals.toString(), textAlign: TextAlign.center)),
            SizedBox(width: 60, child: Text(team.points.toString(), textAlign: TextAlign.center)),
          ],
        ),
      ),
    );
  }
}
