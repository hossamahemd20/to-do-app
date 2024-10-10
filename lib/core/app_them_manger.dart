import 'package:flutter/material.dart';
class ApplicationThemeManger{
  static const Color primaryColor =Color(0xFF5D9CEC);
  static  ThemeData lightThemData =ThemeData(
  scaffoldBackgroundColor:  const Color(0xFFDFECDB),
    primaryColor: primaryColor,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      toolbarHeight: 140,
      backgroundColor: Color(0xff5D9CEC),
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins",
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
        size: 35,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: false,
      unselectedIconTheme: IconThemeData(
        size: 28,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins",
        color: primaryColor,
      ),
      bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins",
          color: primaryColor,

      ),
      bodyMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins",
        color: primaryColor,
      ),
      displayLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.normal,
          fontFamily: "Poppins",
        color: primaryColor,
      ),
      displaySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins",
        color: primaryColor,
    ),
    ),

  );

}