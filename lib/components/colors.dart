import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color primaryVariant = Color(0xFF3700B3);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color secondaryVariant = Color(0xFF018786);
  static const LinearGradient backgroundColor = LinearGradient(
    colors: [Color(0xFFFF0000), Color(0xFF7E2424)], // Change to your desired colors
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const Color errorColor = Color(0xFFB00020);
  static const Color onSecondary = Color(0xFF000000);
  static const Color onSurface = Color(0xFF000000);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color navbarColor = Color(0xFFA41010);
  static const Color appbarColor = Color(0xFFB8040D);

  static const Color teamLogo = Color(0x66D9D9D9);
  static const Color matchCard = Color(0x66D9D9D9);
  static const Color matchDetailsBox = Color(0x66D9D9D9);


// Add more colors as needed
}