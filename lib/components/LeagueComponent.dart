import 'package:flutter/material.dart';
import 'package:untitled/components/colors.dart';
import '../models/league.dart'; // Import your League model
import 'match_item.dart'; // Import the MatchItem component

class LeagueComponent extends StatelessWidget {
  final League league;

  const LeagueComponent({Key? key, required this.league}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0.0), // Reduced vertical margin
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      decoration: BoxDecoration(
        color: AppColors.leagueComponent, // Set background color to white
        borderRadius: BorderRadius.circular(12.0), // Round the corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
       // Set background color to white
      // Margin for spacing between leagues
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
                if (league.leagueLogo != null) // Make sure `leagueLogo` is defined in your League class
                  Image(
                    image: AssetImage(league.leagueLogo),
                    width: 100, // Adjust width as needed
                    height: 100, // Adjust height as needed
                  ),
                const SizedBox(width: 12),
                // League Name
                Text(
                  league.leagueName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),

                ),
                // League Logo

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

                return MatchItem(match: league.matches[index], backgroundColor: backgroundColor!,);
              },
            ),
          ),
        ],
      ),
    );
  }
}
