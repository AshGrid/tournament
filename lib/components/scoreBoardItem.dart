import 'package:flutter/material.dart';

import '../models/Team.dart';
import '../models/match.dart';
import 'colors.dart'; // Import this for Timer

class ScoreboardItem extends StatefulWidget {
  final Match match;

  const ScoreboardItem({
    Key? key,
    required this.match,
  }) : super(key: key);

  @override
  _ScoreboardItemState createState() => _ScoreboardItemState();
}

class _ScoreboardItemState extends State<ScoreboardItem> {
  bool isFavoriteHome = false; // Track favorite state for home team
  bool isFavoriteAway = false; // Track favorite state for away team

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.15,
        padding: const EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First team details (logo and name)
            _buildTeamInfo(context, widget.match.homeTeam, true),

            Spacer(),
            // Middle content: match score and play/pause buttons
            Padding( // Add padding to shift match info to the right
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                children: [
                  Text(widget.match.formattedDate),
                  Text("VS"),
                  _buildMatchDetails(context),
                ],
              ),
            ),
            Spacer(),

            // Second team details (logo and name)
            _buildTeamInfo(context, widget.match.awayTeam, false),
          ],
        ),
      ),
    );
  }

  // Widget to build the team logo and name with border and shadow
  Widget _buildTeamInfo(BuildContext context, Team team, bool isHome) {
    return Column(
      children: [
        IconButton(
          icon: Icon(
            Icons.star,
            color: isHome ? (isFavoriteHome ? AppColors.favoriteIcon : Colors.grey) : (isFavoriteAway ? AppColors.favoriteIcon : Colors.grey),
          ),
          onPressed: () {
            setState(() {
              if (isHome) {
                isFavoriteHome = !isFavoriteHome; // Toggle favorite state for home team
              } else {
                isFavoriteAway = !isFavoriteAway; // Toggle favorite state for away team
              }
            });
          },
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.13,
          height: MediaQuery.of(context).size.width * 0.11,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: AppColors.matchItemComponentTeamLogoBorder, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              team.logo,
              fit: BoxFit.contain,
              width: 50,
              height: 50,
            ),
          ),
        ),
        SizedBox(height: 10.0), // Increased space between logo and name
        Text(
          team.name,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),
        ),
      ],
    );
  }

  // Widget to build the match score and play/pause buttons
  Widget _buildMatchDetails(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Align items at the start
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Match Score
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.match.homeScore}',
                  style: TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 14.0),
                Text(
                  '-',
                  style: TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 14.0),
                Text(
                  '${widget.match.awayScore}',
                  style: TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Placeholder for Play and Pause buttons
          SizedBox(height: 10), // Space for buttons below score
        ],
      ),
    );
  }
}
