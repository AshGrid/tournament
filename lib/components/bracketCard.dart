import 'package:flutter/material.dart';
import 'package:flutter_tournament_bracket/flutter_tournament_bracket.dart';
import '../models/match.dart';
import 'colors.dart'; // Update the import according to your project structure
// Update this import according to your color utility path

class BracketMatchCard extends StatelessWidget {
  final TournamentMatch item;

  const BracketMatchCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.teamLogoBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.teamLogoShadow,
            offset: const Offset(2, 4),
            blurRadius: 4,
          ),
        ],
        color: AppColors.TableauPhaseItem,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(

                      width: MediaQuery.of(context).size.width*0.13,
                      height: MediaQuery.of(context).size.height*0.04,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: AppColors.teamLogoBorder, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.teamLogoShadow,
                            offset: const Offset(2, 2), // Shadow direction and offset
                            blurRadius: 4, // Amount of blur for the shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "assets/images/${item.teamA}.jpg",
                          fit: BoxFit.scaleDown,
                          width: 55,
                          height: 40,
                        ),
                      ),
                    ),
                    SizedBox(width: 30,),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      item.teamA ?? "No Info",
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(

                      width: MediaQuery.of(context).size.width*0.13,
                      height: MediaQuery.of(context).size.height*0.04,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: AppColors.teamLogoBorder, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.teamLogoShadow,
                            offset: const Offset(2, 2), // Shadow direction and offset
                            blurRadius: 4, // Amount of blur for the shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "assets/images/${item.teamB}.jpg",
                          fit: BoxFit.scaleDown,
                          width: 55,
                          height: 40,
                        ),
                      ),
                    ),
                    SizedBox(width: 30,),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      item.teamB ?? "No Info",
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),


          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                item.scoreTeamA ?? "",
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
               SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                item.scoreTeamB ?? "",
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          const SizedBox(
            width: 5,
          )
        ],
      ),
    );
  }
}
