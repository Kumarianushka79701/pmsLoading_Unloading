import 'package:flutter/material.dart';

// Ensure this is at the top level of your Dart file
class AppColors {
  // Primary color variants
  static Color get primary => const Color(0xFF0066FF);
  static Color get primaryLight => const Color(0xFF66A3FF);
  static Color get primaryDark => const Color(0xFF0041B3);
  static Color get primaryAccent => const Color(0xFF3399FF);

  // Secondary color variants
  static Color get secondary => const Color(0xFF3F414E);
  static Color get secondaryAccent => const Color(0xFF4C5160);
  static Color get secondaryComplement => const Color(0xFF003D99);

  // Text colors
  static Color get primaryText => const Color(0xFF3F414E);
  static Color get primaryTextLight => const Color(0xFF66A3FF);
  static Color get secondaryText => const Color(0xFFA1A4B2);

  // Text on darker backgrounds
  static Color get textOnPrimary => const Color(0xFFFFFFFF);
  static Color get textOnSecondary => const Color(0xFFE6E7F2);

  // Background colors
  static Color get backgroundLight => const Color(0xFFF2F3F7);
  static Color get backgroundDark => const Color(0xFF03174C);
  static Color get backgroundPrimaryLight => const Color(0xFFEBF2FF);
  static Color get backgroundPrimaryDark => const Color(0xFF002266);
  static Color get backgroundText => const Color.fromARGB(30, 0, 102, 255);

  // Utilit Colors
  static Color get white => const Color(0xFFFFFFFF);
  static Color get black => const Color(0xFF000000);
  static Color get lightGrey => Colors.grey[500]!;
  static Color get darkGrey => const Color(0xFF3F414E);
}
