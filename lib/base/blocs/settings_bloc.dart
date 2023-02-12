import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/config/app_states.dart';
import 'package:flutter_project_base/routers/navigator.dart';
import 'package:flutter_project_base/utilities/theme/colors/colors.dart';
import 'package:flutter_project_base/utilities/theme/colors/light_theme.dart';
import '../../config/app_events.dart';
import '../../debug/log_printer.dart';
import '../../handlers/localization_handler.dart';
import '../../handlers/shared_handler.dart';

class SettingsBloc extends Bloc<AppEvents, AppStates> {
  SettingsBloc() : super(SettingsDone(lang: 'en', theme: LightTheme())) {
    on<Update>(_update);
    _initSettings();
  }
  ColorsTheme theme = LightTheme();
  String lang = 'en';
  static SettingsBloc get instance => BlocProvider.of(CustomNavigator.navigatorState.currentContext!);

  // Values setters
  set updateLang(String value) {
    if (value != currentLang()) SharedHandler.instance!.setData(SharedKeys().lang, value: value);
    lang = value;
    // AppLocale.of(CustomNavigator.navigatorState.currentContext!).loadLang(updateData: Locale(lang));

    add(Update());
  }

  set updateTheme(ColorsThemeType value) {
    SharedHandler.instance!.setData(SharedKeys().theme, value: value.toString());
    theme = ColorsTheme.themeMapper(value);
    add(Update());
    log_data(label: "Theme update", data: value);
  }

  // Functions
  ColorsThemeType _themeTypeFromString(String value) {
    if (value == ColorsThemeType.darkTheme.toString()) {
      return ColorsThemeType.darkTheme;
    } else {
      return ColorsThemeType.lightTheme;
    }
  }

  _initSettings() {
    // init theme
    String value = SharedHandler.instance!.getData(key: SharedKeys().theme, valueType: ValueType.string);
    if (value.isEmpty) {
      theme = ColorsTheme.themeMapper(ColorsThemeType.lightTheme);
    } else {
      theme = ColorsTheme.themeMapper(_themeTypeFromString(value));
    }
    // init lang
    String cashedLang = SharedHandler.instance!.getData(key: SharedKeys().lang, valueType: ValueType.string);
    lang = (cashedLang.isNotEmpty) ? cashedLang : "en";
    add(Update());
  }

  // Events callback
  _update(AppEvents event, Emitter emit) {
    emit(SettingsDone(lang: lang, theme: theme));
  }
}
