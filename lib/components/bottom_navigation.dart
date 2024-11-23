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
    return

       BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/home.png"),
              color: Colors.white, // Set icon color here
            ),
            label: 'Acceuil',
            backgroundColor: AppColors.navbarColor, // Optional, for item background color
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/field.png"),
              color: Colors.white, // Set icon color here
            ),
            label: 'Matches',
            backgroundColor: AppColors.navbarColor, // Optional, for item background color
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/Star18.png"),
              color: Colors.white, // Set icon color here
            ),
            label: 'Favoris',
            backgroundColor: AppColors.navbarColor, // Optional, for item background color
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/tower.png"),
              color: Colors.white, // Set icon color here
            ),
            label: 'Direct',
            backgroundColor: AppColors.navbarColor, // Optional, for item background color
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/lines.png"),
              color: Colors.white, // Set icon color here
            ),
            label: 'Menu',
            backgroundColor: AppColors.navbarColor, // Optional, for item background color
          ),
        ],
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: AppColors.navbarColor, // Make background transparent to use Container color
        selectedItemColor: Colors.white, // Set color for selected item
        unselectedItemColor: Colors.white54, // Set color for unselected items

    );
  }
}
