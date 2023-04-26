import 'package:flutter/material.dart';

class AppTheme{

  static ThemeData lightTheme(){
    return ThemeData(
      primarySwatch: Colors.blue,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.dark();
  }
}