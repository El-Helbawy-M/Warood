import 'package:flutter_project_base/debug/log_printer.dart';
import 'package:flutter_project_base/handlers/shared_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../../utilities/theme/colors/colors.dart';

class ThemeBloc {
  // observer objects
  var theme = BehaviorSubject<ColorsTheme?>();

  // observer value setters
  set updateTheme(ColorsThemeType value) {
    SharedHandler.instance!.setData(SharedKeys().theme, value: value.toString());
    theme.sink.add(ColorsTheme.themeMapper(value));
    log_check(label: "Theme update", currentValue: theme.valueOrNull, expectedValue: value);
  }

  // observer streams
  Stream<ColorsTheme?> get themeStream => theme.stream.asBroadcastStream();

  // Functions
  void initTheme() {
    String value = SharedHandler.instance!.getData(key: SharedKeys().theme, valueType: ValueType.string);
    if (value.isEmpty) {
      updateTheme = ColorsThemeType.lightTheme;
    } else {
      theme.sink.add(ColorsTheme.themeMapper(_themeTypeFromString(value)));
    }
    log_check(label: "Theme update", currentValue: theme.valueOrNull, expectedValue: value);
  }

  ColorsThemeType _themeTypeFromString(String value) {
    if (value == ColorsThemeType.darkTheme.toString()) {
      return ColorsThemeType.darkTheme;
    } else {
      return ColorsThemeType.lightTheme;
    }
  }
}

ThemeBloc themeBloc = ThemeBloc();
