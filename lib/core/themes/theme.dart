import 'package:finance/core/themes/colors.dart';
import 'package:flutter/material.dart';

class Apptheme {
  static ThemeData lighttheme = ThemeData(
    //scaffold background color
    scaffoldBackgroundColor: AppColors.appWhite,
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
      onSurface: Colors.black, // Main text color
      onBackground: Colors.black,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.appBlack,
    colorScheme: const ColorScheme.dark(
      primary: Colors.blue,
      onSurface: Colors.white, // Main text color
      onBackground: Colors.white,
    ),
  );
}
