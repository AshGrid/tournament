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
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: AppColors.navbarColor,

        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Matches',
          backgroundColor: AppColors.navbarColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
          backgroundColor: AppColors.navbarColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Fantasy',
          backgroundColor: AppColors.navbarColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more),
          label: 'More',
          backgroundColor: AppColors.navbarColor,
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,

    );
  }
}
