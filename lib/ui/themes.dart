

import 'package:flutter/material.dart';

const primaryColor = Color(0xFF3383FB);
const backgroundLightColor = Color(0xFFFCFCFC);
const backgroundDarkColor = Color(0xFF1F2026);
const navigationBarLightColor = Colors.white;
const navigationBarDarkColor = Color(0xFF30313C);

class Themes{

  static final themeLight = ThemeData.light().copyWith(
    backgroundColor: backgroundLightColor,
    //Selected color
    accentColor: primaryColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white
    ),
    //Bottom bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: navigationBarLightColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey[200],
    ),
    //Switch active color
    toggleableActiveColor: primaryColor,
    canvasColor: backgroundLightColor,
    appBarTheme: AppBarTheme(
      color: Colors.black
    )
  );

  static final themeDark = ThemeData.dark().copyWith(
    backgroundColor: backgroundDarkColor,
    //Selected color
    accentColor: primaryColor,
    //floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white
    ),
    //Bottom bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: navigationBarDarkColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey[300],
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.white
    ),
    //Switch active color
    toggleableActiveColor: primaryColor,
    canvasColor: backgroundDarkColor,
    appBarTheme: AppBarTheme(
      color: Colors.white
    )
  );
}