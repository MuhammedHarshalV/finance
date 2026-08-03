import 'package:finance/core/themes/theme.dart';

import 'package:finance/presentation/screens/bottom_nav_screen/screen/bottom_nav_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavScreen(),
      themeMode: ThemeMode.system,
      theme: Apptheme.lighttheme.copyWith(
        scaffoldBackgroundColor: Apptheme.lighttheme.scaffoldBackgroundColor,
        // appBarTheme: Apptheme.lighttheme.appBarTheme.copyWith(
        //   systemOverlayStyle: SystemUiOverlayStyle(
        //     statusBarColor: Colors.transparent,
        //     statusBarIconBrightness: Brightness.dark,
        //     systemNavigationBarColor: Colors.transparent,
        //     //Apptheme.lighttheme.scaffoldBackgroundColor,
        //     systemNavigationBarIconBrightness: Brightness.dark,
        //     systemNavigationBarDividerColor: Colors.transparent,
        //   ),
        // ),
      ),
      darkTheme: Apptheme.darkTheme.copyWith(
        scaffoldBackgroundColor: Apptheme.darkTheme.scaffoldBackgroundColor,
        // appBarTheme: Apptheme.darkTheme.appBarTheme.copyWith(
        //   systemOverlayStyle: SystemUiOverlayStyle(
        //     statusBarColor: Colors.transparent,
        //     statusBarIconBrightness: Brightness.light,
        //     systemNavigationBarColor:
        //         Apptheme.darkTheme.scaffoldBackgroundColor,
        //     systemNavigationBarIconBrightness: Brightness.light,
        //     systemNavigationBarDividerColor: Colors.transparent,
        //   ),
        // ),
      ),
    );
  }
}
