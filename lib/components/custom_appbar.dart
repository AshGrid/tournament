import 'package:flutter/material.dart';


import '../screens/bottom_sheet.dart';
import '../screens/profile_screen.dart';
import 'story_circle.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      leadingWidth: 100,
      toolbarHeight: 100,


      leading: Builder(

        builder: (BuildContext context) {

          return SizedBox(
            height: 350,
            width: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                StoryCircle(
                  imageUrls: [
                    'assets/images/ahri.jpg',
                    'assets/images/itachi.jpg',
                    'assets/images/jabami.jpg',
                  ],
                  userName: 'User 1',
                ),


              ],
            ),
          );
        },
      ),
      actions: <Widget>[
        IconButton(
          iconSize: 52,
          icon: const Icon(Icons.person),
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
