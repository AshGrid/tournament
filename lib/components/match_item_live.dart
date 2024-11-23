import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Match.dart';
import 'colors.dart'; // Ensure the Match class is correctly imported

class MatchItemLive extends StatelessWidget {
  final Match match;
  final Color backgroundColor;
  final bool isLastItem;
  final bool isFirstItem;

  const MatchItemLive({
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


    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: isLastItem ?  BorderSide(color: Color(0xFFFFFFFF), width: 2) :  BorderSide(color: Color(0xFFFFFFFF), width: 2),
          top: !isFirstItem ? BorderSide.none : const BorderSide(color: Color(0xFFFFFFFF), width: 2),
        ),
      ),
      child: Row(
        children: [
          // Match time on the left
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(width: 70,
            child:Text(
              "${_formatDate(match.date)}", // Use match.matchTime if it's dynamic
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Oswald'),
            ),
              )
          ),
          // Conditional vertical line or match time

            Container(
              width: 1,
              height: 70, // Adjust the height of the divider line
              color: AppColors.timeLogoSeperator,
            ),

          const SizedBox(width: 7 ),
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
                    const SizedBox(height: 8),
                    // Space between team 1 and team 2
                    // Team 2 logo and name
                    _buildTeamLogo("${match.away!.logo}", match.away!.name),
                  ],
                ),
                // Conditional match time or line separator

                Spacer(),
                if(match.is_ended == true) ...[
                  Text("Terminé", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white),),
                ]
                else if(match.status=='live' && match.is_ended == false) ...[
                  Text("En cours", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white),),
                ],
                SizedBox(width: 10,),
                Container(
                  width: 1,
                  height: 70, // Adjust the height of the divider line
                  color: AppColors.timeLogoSeperator,
                ),

                if (match.status!.isNotEmpty && match.status != null || match.is_ended! ) ...[


                  SizedBox(width: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 17.0,left: 12),
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

                        children: [
                          Text(
                            "${match.home_first_half_score!+match.home_second_half_score!}", // Home team score
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const Text(
                            "",
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          Text(
                            "${match.away_first_half_score!+match.away_second_half_score!}", // Away team score
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),)

                ] else ...[
                  SizedBox(width: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25,right: 15),
                    child: Text(
                      match.time != null
                          ? "${parseTime(match.time!).format(context)}" // Display match time if live
                          : 'TBD', // Display match time if live
                      style: const TextStyle(fontSize: 10 , fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  ),
                ],
                // Score on the far right

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
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }

  TimeOfDay parseTime(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

}
