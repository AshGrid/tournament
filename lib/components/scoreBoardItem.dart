import 'package:flutter/material.dart';
import 'package:untitled/screens/teamPage.dart';

import '../models/Team.dart';
import '../models/match.dart';
import 'colors.dart'; // Import this for Timer

class ScoreboardItem extends StatefulWidget {
  final Match match;
  final Function(Team) onTeamSelected;
  const ScoreboardItem({
    Key? key,
    required this.match, required this.onTeamSelected,
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
        height: MediaQuery.of(context).size.height * 0.156,
        padding: const EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 20,),
            // First team details (logo and name)
            _buildTeamInfo(context, widget.match.homeTeam, true),

            Spacer(),
            // Middle content: match score and play/pause buttons
            Padding( // Add padding to shift match info to the right
              padding: const EdgeInsets.only(left: 0.0),
              child: Column(
                children: [
                  SizedBox(height: 7,),


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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
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
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.075,
          padding: EdgeInsets.all(0),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: AppColors.matchItemComponentTeamLogoBorder, width: 2),

          ),
          child: GestureDetector(
            onTap: () {
              widget.onTeamSelected(team);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                team.logo,
                fit: BoxFit.fill,

              ),
            ),
          ),
        ),
        //SizedBox(height: 10.0), // Increased space between logo and name
        Text(
          team.name,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),
        ),
      ],
    );
  }

  // Widget to build the match score and play/pause buttons
  Widget _buildMatchDetails(BuildContext context) {
    return Container(
       child:  MediaQuery.removePadding(context: context,removeBottom: true,removeTop: true, child: Column(

         mainAxisAlignment: MainAxisAlignment.end,
         crossAxisAlignment: CrossAxisAlignment.center,
         children:  [
           Text(widget.match.formattedDate,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),),
           Text("VS",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20,)),
         MediaQuery.removePadding(context: context,removeBottom: true,removeTop: true, child: Row(
           children: [
             Text(widget.match.homeScore.toString(),
               style: TextStyle(fontSize: 27.0, color: Colors.black, fontWeight: FontWeight.bold),),
             SizedBox(width: 30,),
             Text("-",style: TextStyle(fontSize: 27.0, color: Colors.black, fontWeight: FontWeight.bold),),
             SizedBox(width: 30,),
             Text(widget.match.awayScore.toString(),
               style: TextStyle(fontSize: 27.0, color: Colors.black, fontWeight: FontWeight.bold),),
           ],
         )),


         ],
       )),

    );
  }
}
