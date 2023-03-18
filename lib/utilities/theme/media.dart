import 'package:flutter/material.dart';
import 'package:flutter_project_base/routers/navigator.dart';

abstract class MediaHelper {
  static double get width => MediaQuery.of(CustomNavigator.navigatorState.currentContext!).size.width;
  static double get height => MediaQuery.of(CustomNavigator.navigatorState.currentContext!).size.height;
}
