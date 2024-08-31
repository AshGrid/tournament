import 'package:flutter/material.dart';
import 'package:untitled/components/colors.dart';

import '../screens/bottom_sheet.dart';
import '../screens/profile_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 100,
      toolbarHeight: 100,
      backgroundColor: AppColors.appbarColor,

      // Replace StoryCircle with IconButton for lines.png
      leading: IconButton(
        iconSize: 52,
        icon: const ImageIcon(AssetImage("assets/icons/lines.png")),
        onPressed: () {
          _showBottomSheet(context);
        },
        tooltip: 'Open Bottom Sheet',
      ),

      actions: <Widget>[
        IconButton(
          iconSize: 52,
          icon: const ImageIcon(AssetImage("assets/icons/dotsPNG.png")),
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
