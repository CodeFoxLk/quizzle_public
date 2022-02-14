import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzle/configs/configs.dart';

mixin SubThemeData {
  AppBarTheme getAppBarTheme() {
    return const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
  }

  BottomAppBarTheme getBottomAppBarTheme() {
    return const BottomAppBarTheme(color: Colors.transparent, elevation: 0);
  }

  TextTheme getTextThemes() {
    return GoogleFonts.quicksandTextTheme(const TextTheme(
        bodyText1: TextStyle(fontWeight: FontWeight.w400),
        bodyText2: TextStyle(fontWeight: FontWeight.w400)));
    // return const TextTheme(
    //     bodyText1: TextStyle(fontWeight: FontWeight.bold),
    //     bodyText2: TextStyle(fontWeight: FontWeight.bold));
  }

  InputDecorationTheme getInputDecoration() {
    return const InputDecorationTheme();
  }

  IconThemeData getIconTheme() {
    return const IconThemeData(color: kOnSurfaceTextColor, size: 16);
  }

  ButtonStyle getElavatedButtonTheme() {
    return ElevatedButton.styleFrom(primary: Colors.white);
  }

  BottomNavigationBarThemeData getBottomNavigationBarTheme() {
    return const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false);
  }
}
