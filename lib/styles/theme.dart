import 'package:flutter/material.dart';

ThemeData buildShrineTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.lightBlue[800],
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.deepOrange[600]),
    fontFamily: 'Georgia',
    textTheme: TextTheme(
      button: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, backgroundColor: Colors.black
      ),
      bodyText2: TextStyle(fontSize: 14.0 , fontFamily: 'Hind'),
    )
  );
}