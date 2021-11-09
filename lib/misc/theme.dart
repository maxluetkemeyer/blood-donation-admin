import 'package:flutter/material.dart';

const Color _primaryColor = Colors.blue;

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 242, 242, 247),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: _primaryColor,
  ),
);

ThemeData darkTheme = ThemeData.dark();
