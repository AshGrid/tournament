import 'package:flutter/material.dart';
import 'package:untitled/components/colors.dart';


import '../screens/bottom_sheet.dart';
import '../screens/profile_screen.dart';
import 'story_circle.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SliverAppBar(
      leadingWidth: 100,
      toolbarHeight: 80,
      backgroundColor: AppColors.appbarColor,


      leading: Builder(

        builder: (BuildContext context) {

          return SizedBox(
            height: 100,
            width: 120,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.all(8.0), // Padding inside the container
                  decoration: BoxDecoration(
                    gradient: AppColors.trophyButton, // Use your predefined gradient color
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    border: Border.all(color: Colors.white, width: 2), // White border
                  ),
                  child: IconButton(
                    iconSize: 100,
                    onPressed: () {
                      _showBottomSheet(context);
                    },
                    tooltip: 'Open Bottom Sheet',
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        // First custom icon positioned to the left
                        Positioned(
                          left: 0,
                          child: Image.asset(
                            'assets/icons/trophy.png', // Path to your first custom icon
                            width: 20,
                            height: 20,
                             // Optional: Set color if needed
                          ),
                        ),
                        // Second custom icon positioned to the right
                        Positioned(
                          right: 0,
                          child: Image.asset(
                            'assets/icons/down.png', // Path to your second custom icon
                            width: 20,
                            height: 20,
                             color: Colors.white,
                             // Optional: Set color if needed
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );


        },
      ),

      actions: <Widget>[
        IconButton(
          iconSize: 52,
          icon: const ImageIcon(AssetImage("assets/icons/profil.png"),
          color: Colors.white,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
      ],

    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetContent();
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}
