import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colours/colors.dart';

ThemeData darkTheme = ThemeData(
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white
      )
  ),
  fontFamily: 'nounsFont',
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarBrightness: Brightness.light,),
      backgroundColor: HexColor('333739'),
      titleTextStyle: TextStyle(
        color: Colors.red
        ,fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
      iconTheme: IconThemeData(
        color: Colors.red,

      )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red,
      backgroundColor: HexColor('333739'),
      elevation: 20
  ),
);

ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: Colors.black
      )
  ),
  fontFamily: 'nounsFont2',
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,),
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.deepPurple
        ,fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
      iconTheme: IconThemeData(
          color: Colors.deepPurple
      )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepPurple,
      backgroundColor: Colors.white,
      elevation: 20
  ),
);
