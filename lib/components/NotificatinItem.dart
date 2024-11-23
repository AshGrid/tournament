import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Required for date/time formatting
import '../models/Match.dart';
import '../components/colors.dart'; // Import colors used in the widget

class NotificationItem extends StatelessWidget {
  final Match match;
  final String clubName;
  final String logo;

  const NotificationItem({
    Key? key,
    required this.match,
    required this.clubName,
    required this.logo,
  }) : super(key: key);

  // Helper function to determine the match time and status
  String getNotificationDescription() {
    List<String> description = [
      'Restez prêt ! Votre club préféré, ${clubName}, entre en jeu dans une heure. Soyez au rendez-vous ! ⚽',
      'Encore un jour avant le match ! Votre club préféré, ${clubName}, ne fait son entrée sur le terrain que demain. Marquez la date et soyez prêts à les soutenir ! 🎉💪⚽',
      'Le moment est arrivé ! ${clubName} est actuellement en train de jouer. Restez connectés pour suivre toute l’action en direct ! 🔥⚽',
      'C’est aujourd’hui le grand jour ! ${clubName} joue un match important. Ne manquez pas l’occasion de les encourager ! 🙌⚽'
    ];

    // Get current date and time
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day); // Create a DateTime for today
    // Check if the match has a valid date and time
    if (match.date != null && match.time != null) {
      // Parse the time string
      final timeParts = match.time!.split(':');
      final matchDateTime = DateTime(
        match.date!.year,
        match.date!.month,
        match.date!.day,
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );

      // Calculate time difference between now and match time
      final timeDiff = matchDateTime.difference(now);

      if (match.status == 'live') {
        return description[2]; // Return live match description
      } else if (timeDiff.inMinutes <= 60 && timeDiff.isNegative == false) {
        return description[0]; // Return "one hour" description
      } else if (timeDiff.inHours <= 24 && timeDiff.isNegative == false) {
        return description[1]; // Return "one day" description
      }
      else if (matchDateTime.year == today.year && matchDateTime.month == today.month && matchDateTime.day == today.day) {
        return description[3]; // Return description for today's match
      }
    }

    return 'Le match est prévu bientôt !'; // Default fallback description
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.17,
      padding: const EdgeInsets.all(10), // Added padding for better spacing
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.white),
      ),
      child: _buildNotifItem(context, match),
    );
  }

  Widget _buildNotifItem(BuildContext context, Match notif) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center, // Center align the row
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.18,
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: AppColors.matchItemComponentTeamLogoBorder,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 5.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
                logo,
                fit: BoxFit.fill,
            ),
            // Add your image widget here
          ),
        ),
        SizedBox(width: 15), // Spacing between the image and title
        Expanded(
          // Make this section flexible
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
            mainAxisAlignment: MainAxisAlignment.center, // Center align text vertically
            children: [
              Text(
                '${match.home!.name} vs ${match.away!.name}', // Match title
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Adjust the color as needed
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 5), // Spacing between title and description
              Text(
                getNotificationDescription(), // Dynamic description based on match time
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black, // Adjust the color as needed
                ),
                textAlign: TextAlign.left,
                maxLines: 4, // Reasonable max lines for description
                overflow: TextOverflow.ellipsis, // Show ellipsis for overflow
              ),
            ],
          ),
        ),
      ],
    );
  }
}
