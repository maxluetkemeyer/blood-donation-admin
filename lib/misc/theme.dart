import 'package:flutter/material.dart';

const Color _primaryColor = Color.fromRGBO(11, 72, 116, 1);

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 242, 242, 247),
  primarySwatch: createMaterialColor(_primaryColor),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: _primaryColor,
  ),
);

//ThemeData darkTheme = ThemeData.dark();
ThemeData darkTheme = lightTheme;

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
