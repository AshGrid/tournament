import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';

import 'colors.dart';

import '../models/Match.dart';



class MatchResume extends StatelessWidget {
  // List of events
  final Match match;

  const MatchResume({Key? key, required this.match}) : super(key: key);

  // Method to get the appropriate custom icon path based on the event description
  String _getIconPathForEvent(String description) {
    switch (description) {
      case "Goal":
        return 'assets/icons/ball.png'; // Path to your goal icon
      case "Yellow Card":
        return 'assets/icons/yellowCard.png'; // Path to your yellow card icon
      case "Red Card":
        return 'assets/icons/redCard.png'; // Path to your red card icon
      case "Player Out":
        return 'assets/icons/arrowDown.png';
      case "Player In":
        return 'assets/icons/arrowUP.png';
    // Add more cases for different event descriptions as needed
      default:
        return 'assets/icons/default_event_icon.png'; // Path to a default icon if no match
    }
  }





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
      // child: Scrollbar(
      //   // Add scrollbar to the list
      //   child: ListView.builder(
      //     itemCount:11,
      //     itemBuilder: (context, index) {
      //       final event = MockData.createMockMatchEvents[index];
      //       String timeString = '${event.time.hour}:${event.time.minute.toString().padLeft(2, '0')}';
      //
      //       return Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           // Event details for the first team (team1) on the left
      //           if (event.team == match.homeSecondHalfScore) // Check if event team is the first team
      //             Expanded(
      //               child: Container(
      //                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      //                 alignment: Alignment.centerLeft,
      //                 child: Row(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Image.asset(
      //                       _getIconPathForEvent(event.description),
      //                       width: 24, // Adjust width as needed
      //                       height: 24, // Adjust height as needed
      //                     ),
      //                     SizedBox(width: 10),
      //                     Row(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         SizedBox(width: 10),
      //                         Text(
      //                           event.playerName,
      //                           style: TextStyle(fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold),
      //                         ), // Player name
      //                         if (event.assistPlayerName != null && event.assistPlayerName!.isNotEmpty)
      //                           Text(
      //                             ' (${event.assistPlayerName})',
      //                             style: TextStyle(fontSize: 15, color: Colors.grey[300],fontWeight: FontWeight.bold),
      //                           ),
      //                         SizedBox(width: 10),
      //                         Text(
      //                           timeString,
      //                           style: TextStyle(fontSize: 12, color: Colors.white),
      //                         ), // Time
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           // Event details for the second team (team2) on the right
      //           if (event.team == match.away) // Check if event team is the second team
      //             Expanded(
      //               child: Container(
      //                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      //                 alignment: Alignment.centerRight,
      //                 child: Row(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   mainAxisAlignment: MainAxisAlignment.end,
      //                   children: [
      //                     Row(
      //                       crossAxisAlignment: CrossAxisAlignment.end,
      //                       children: [
      //                         SizedBox(width: 10),
      //                         Text(
      //                           event.playerName,
      //                           style: TextStyle(fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold),
      //                         ), // Player name
      //                         if (event.assistPlayerName != null && event.assistPlayerName!.isNotEmpty)
      //                           Text(
      //                             ' ${event.assistPlayerName}',
      //                             style: TextStyle(fontSize: 15, color: Colors.grey[300],fontWeight: FontWeight.bold),
      //                           ),
      //
      //                         SizedBox(width: 10),
      //                         Text(
      //                           timeString,
      //                           style: TextStyle(fontSize: 12, color: Colors.white),
      //                         ), // Time
      //                       ],
      //                     ),
      //                     SizedBox(width: 10),
      //                     Image.asset(
      //                       _getIconPathForEvent(event.description),
      //                       width: 24, // Adjust width as needed
      //                       height: 24, // Adjust height as needed
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //         ],
      //       );
      //
      //     },
      //   ),
      // ),
    );
  }
}
