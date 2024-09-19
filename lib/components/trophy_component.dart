import 'package:flutter/material.dart';
import 'package:untitled/components/colors.dart';
import '../models/league.dart'; // Import your League model
import 'match_item.dart'; // Import the MatchItem component

class TrophyComponent extends StatelessWidget {
  final League league;

  const TrophyComponent({Key? key, required this.league}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0.0), // Reduced vertical margin
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      decoration: BoxDecoration(
        color: AppColors.leagueComponent, // Set background color
        borderRadius: BorderRadius.circular(12.0), // Round the corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // League Name and Logo in a separate box
          Container(
            height: 80,
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.white, // Light grey background for the box
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                if (league.leagueLogo != null) ...[
                  // League Logo with rounded box
                  Container(
                    width: 90, // Adjust width as needed
                    height: 90, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of the rounded box
                      borderRadius: BorderRadius.circular(12.0), // Rounded corners
                      border: Border.all(color: Colors.black12, width: 2), // Rounded border
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 6,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0), // Match the container's border radius
                      child: Image.asset(
                        league.leagueLogo,
                        fit: BoxFit.scaleDown,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                // League Name
                Text(
                  league.leagueName,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // List of MatchItems
          SizedBox(
            height: 180, // Adjust height to show 2 items (e.g., 2 * 90 = 180)
            child: ListView.builder(
              itemCount: league.matches.length,
              itemBuilder: (context, index) {
                // Alternate background colors
                final backgroundColor = index.isEven ? AppColors.matchItem1 : Colors.transparent;

                return MatchItem(
                  match: league.matches[index],
                  backgroundColor: backgroundColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
