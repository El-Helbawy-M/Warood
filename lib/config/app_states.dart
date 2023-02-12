import 'package:flutter_project_base/base/models/mapper.dart';
import 'package:flutter_project_base/utilities/theme/colors/colors.dart';

abstract class AppStates {}

class Start extends AppStates {}

class Done extends AppStates {
  dynamic data;
  Map? mapedData;
  Mapper? model;
  Done({this.model, this.data, this.mapedData});
}

class SettingsDone extends AppStates {
  ColorsTheme theme;
  String lang;
  SettingsDone({required this.lang, required this.theme});
}

class Empty extends AppStates {}

class Error extends AppStates {}

class Loading extends AppStates {}

class NoLocation extends AppStates {}
