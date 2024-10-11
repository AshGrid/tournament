import 'package:flutter/material.dart';
import '../models/Club.dart';
import '../models/Team.dart';
import 'colors.dart'; // Adjust the path as necessary to import your Team model

class TeamItem extends StatelessWidget {
  final Club club;
  final int index;

  const TeamItem({Key? key, required this.club, required this.index}) : super(key: key);

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
                  club.order_main_page.toString(),
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
                      child: Image.network(
                        club.logo!,
                        width: 40, // Adjust the logo size as needed
                        height: 40,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8), // Add some space between logo and team name
                SizedBox(width: 80,child: Text(
                  club.name,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),)
              ],
            ),
            SizedBox(width: 60, child: Text(/*team.matchesPlayed.toString()*/"4", textAlign: TextAlign.right)),
            SizedBox(width: 60, child: Text(/*team.goals.toString()*/'6', textAlign: TextAlign.center)),
            SizedBox(width: 60, child: Text(/*team.points.toString()*/'7', textAlign: TextAlign.center)),
          ],
        ),
      ),
    );
  }
}
