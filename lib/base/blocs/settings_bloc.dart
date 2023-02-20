import 'package:flutter_project_base/base/models/settings_model.dart';
import 'package:flutter_project_base/handlers/localization_handler.dart';
import 'package:flutter_project_base/handlers/shared_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../../utilities/theme/colors.dart';

class SettingsBloc {
  init() {
    SettingsModel model = SettingsModel(lang: "en", theme: ColorsThemeType.lightTheme);
    // init theme
    String theme = SharedHandler.instance!.getData(key: SharedKeys().theme, valueType: ValueType.string);
    if (theme.isEmpty) {
      model.theme = ColorsThemeType.lightTheme;
    } else {
      model.theme = _themeTypeFromString(theme);
    }
    // init lang
    String lang = SharedHandler.instance!.getData(key: SharedKeys().lang, valueType: ValueType.string);
    model.lang = (lang != "") ? lang : "en";

    // init settings
    settingsModel.sink.add(model);
  }

  final settingsModel = BehaviorSubject<SettingsModel?>();

  set updateLang(String value) {
    if (value != currentLang()) SharedHandler.instance!.setData(SharedKeys().lang, value: value);
    settingsModel.valueOrNull!.lang = value;
    settingsModel.sink.add(settingsModel.valueOrNull);
  }

  // observer value setters
  set updateTheme(ColorsThemeType value) {
    SharedHandler.instance!.setData(SharedKeys().theme, value: value.toString());
    settingsModel.valueOrNull!.theme = value;
    settingsModel.sink.add(settingsModel.valueOrNull);
  }

  ColorsThemeType _themeTypeFromString(String value) {
    if (value == ColorsThemeType.darkTheme.toString()) {
      return ColorsThemeType.darkTheme;
    } else {
      return ColorsThemeType.lightTheme;
    }
  }

  Stream<SettingsModel?> get settingsModelStream => settingsModel.stream.asBroadcastStream();
}

SettingsBloc settings = SettingsBloc();
