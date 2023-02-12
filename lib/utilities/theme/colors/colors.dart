import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

abstract class ColorsTheme {
  late Color primary;
  late Color secondery;
  late Color borderColor;
  late Color greyTitle;
  late Color background;
  late Color error;
  late Color inactiveProgress;
  late Color mainTextColor;
  late Color hintTextColor;
  late Color inActiveColor;
  late Color pendingColor;
  late Color activeColor;
  late Color notStartedColor;

  static ColorsTheme themeMapper(ColorsThemeType value) {
    switch (value) {
      case ColorsThemeType.lightTheme:
        return LightTheme();
      case ColorsThemeType.darkTheme:
        return DarkTheme();
      default:
        return LightTheme();
    }
  }
}

enum ColorsThemeType { lightTheme, darkTheme }
