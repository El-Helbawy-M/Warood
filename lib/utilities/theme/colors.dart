import 'package:flutter/material.dart';

enum ColorsThemeType { lightTheme, darkTheme }

class ColoresThemes {
  ThemeData lightTheme(String fontFamily) => ThemeData(
        primaryColor: const Color(0xff019147),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xff019147), elevation: 0),
        hintColor: const Color(0xff737373),
        backgroundColor: Colors.white,
        fontFamily: fontFamily,
        textTheme: const TextTheme(titleLarge: TextStyle(color: Color(0xff373737))),
        colorScheme: const ColorScheme.light(
          secondary: Color(0xfffceecb),
          error: Color(0xffF70000),
        ),
      );
  ThemeData dartTheme(String fontFamily) => ThemeData(
        primaryColor: const Color(0xff2a3780),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xff2a3780), elevation: 0),
        hintColor: const Color(0xff737373),
        backgroundColor: const Color(0xff37468b),
        fontFamily: fontFamily,
        textTheme: const TextTheme(titleLarge: TextStyle(color: Color(0xff373737))),
        colorScheme: const ColorScheme.light(
          secondary: Color(0xffffdd55),
          error: Color(0xffF70000),
        ),
      );
  ThemeData mapColor(ColorsThemeType type, String fontFamily) {
    switch (type) {
      case ColorsThemeType.lightTheme:
        return lightTheme(fontFamily);
      case ColorsThemeType.darkTheme:
        return dartTheme(fontFamily);
    }
  }
}
