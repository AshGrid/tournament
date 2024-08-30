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
          label: 'Acceuil',
          backgroundColor: AppColors.navbarColor,

        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage("assets/icons/field.png"),
            color: Colors.black,),
          label: 'Matches',

          backgroundColor: AppColors.navbarColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Favoris',
          backgroundColor: AppColors.navbarColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Boutique',
          backgroundColor: AppColors.navbarColor,
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage("assets/icons/shirt.png"),),
          label: 'Fantasy',
          backgroundColor: AppColors.navbarColor,
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.white, // Set color for the selected item
      unselectedItemColor: Colors.white,
      onTap: onTap,

    );
  }
}
