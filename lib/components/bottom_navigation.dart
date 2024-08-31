import 'package:flutter/material.dart';
import 'colors.dart';
class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage("assets/icons/home.png"),
          ),
          label: 'Acceuil',
          backgroundColor: AppColors.navbarColor,

        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage("assets/icons/field.png"),
            ),
          label: 'Matches',

          backgroundColor: AppColors.navbarColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star_outline),
          label: 'Favoris',
          backgroundColor: AppColors.navbarColor,
        ),

        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage("assets/icons/shirt.png"),),
          label: 'Fantasy',
          backgroundColor: AppColors.navbarColor,
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage("assets/icons/lines.png"),),
          label: 'Menu',
          backgroundColor: AppColors.navbarColor,
        ),
      ],
      currentIndex: currentIndex,

      onTap: onTap,

    );
  }
}
