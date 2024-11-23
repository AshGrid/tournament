import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Match.dart';
import 'colors.dart'; // Ensure the Match class is correctly imported

class MatchItemCalendar extends StatelessWidget {
  final Match match;
  final Color backgroundColor;
  final bool isLastItem;
  final bool isFirstItem;

  const MatchItemCalendar({
    Key? key,
    required this.match,
    required this.backgroundColor,
    this.isLastItem = false,
    this.isFirstItem = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _formatDate(DateTime? date) {
      if (date == null) {
        return "TBD"; // Default value if date is null
      }
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      return formatter.format(date);
    }

    String _formatTime(String? timeString) {
      if (timeString == null || timeString.isEmpty) return 'TBD';

      // Split the time string into hours and minutes
      final timeParts = timeString.split(':');
      if (timeParts.length != 3) return 'TBD'; // Return empty if the format is invalid

      final hours = int.tryParse(timeParts[0]);
      final minutes = int.tryParse(timeParts[1]);

      // Validate hours and minutes
      if (hours == null || minutes == null || hours < 0 || hours > 23 || minutes < 0 || minutes > 59) {
        return 'TBD'; // Return empty if invalid
      }

      // Create a DateTime object
      final dateTime = DateTime.now().copyWith(hour: hours, minute: minutes);

      // Format the DateTime object to 'HH:mm'
      return DateFormat('HH:mm').format(dateTime); // Example: "14:30"
    }

    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: isLastItem
              ? BorderSide(color: Color(0xFFFFFFFF), width: 2)
              : BorderSide(color: Color(0xFFFFFFFF), width: 2),
          top: !isFirstItem
              ? BorderSide.none
              : const BorderSide(color: Color(0xFFFFFFFF), width: 2),
        ),
      ),
      child: Row(
        children: [
          // Match time on the left
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "${_formatDate(match.date)}", // Use match.matchTime if it's dynamic
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Oswald'),
            ),
          ),
          // Conditional vertical line or match time

          Container(
            width: 1,
            height: 70, // Adjust the height of the divider line
            color: AppColors.timeLogoSeperator,
          ),

          const SizedBox(width: 7),
          Expanded(
            child: Row(
              children: [
                // Teams column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    // Team 1 logo and name
                    _buildTeamLogo("${match.home!.logo}", match.home!.name),
                    const SizedBox(
                        height: 8), // Space between team 1 and team 2
                    // Team 2 logo and name
                    _buildTeamLogo("${match.away!.logo}", match.away!.name),
                  ],
                ),
                // Conditional match time or line separator

                Spacer(),

                // Score on the far right
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: 60, // Width of the container
                    height: 80, // Height of the container
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.transparent, width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Container(
                            width: 1,
                            height: 70, // Adjust the height of the divider line
                            color: AppColors.timeLogoSeperator,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                             _formatTime(match.time)??'TBD', // Display match date
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ])
                        // Show score if the match status is not empty
                      ],
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

  // Helper method to build the team logo with rounded corners, shadow, and team name
  Widget _buildTeamLogo(String logoPath, String teamName) {
    return Row(
      children: [
        Container(
          width: 50, // Adjusted width
          height: 35, // Adjusted height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: AppColors.teamLogoBorder, width: 1),
            boxShadow: const [
              BoxShadow(
                color: AppColors.teamLogoShadow,
                offset: Offset(2, 2), // Shadow direction and offset
                blurRadius: 4, // Amount of blur for the shadow
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: Image.network(
              logoPath,
              fit: BoxFit.scaleDown,
              width: 50,
              height: 35,
            ),
          ),
        ),
        const SizedBox(width: 8), // Space between logo and team name
        Text(
          teamName,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }
}
