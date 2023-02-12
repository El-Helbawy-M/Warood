import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_base/base/blocs/settings_bloc.dart';
import 'package:flutter_project_base/config/app_events.dart';
import 'package:flutter_project_base/debug/log_printer.dart';
import '../routers/navigator.dart';

class AppLocale {
  late Locale locale;

  AppLocale(this.locale);

  late Map<String, String> _loadedLocalizedValues;

  static AppLocale of(BuildContext context) {
    return Localizations.of(context, AppLocale);
  }

  Future loadLang({Locale? updateData}) async {
    log_data(label: "check locale", data: updateData ?? locale.languageCode);
    String langFile = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> loadedValues = jsonDecode(langFile);
    _loadedLocalizedValues = loadedValues.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslated(String key) {
    return _loadedLocalizedValues[key]!;
  }

  static const LocalizationsDelegate<AppLocale> delegate = _AppLocalDelegate();
}

class _AppLocalDelegate extends LocalizationsDelegate<AppLocale> {
  const _AppLocalDelegate();
  @override
  bool isSupported(Locale locale) {
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocale> load(Locale locale) async {
    AppLocale appLocale = AppLocale(locale);
    await appLocale.loadLang();
    return appLocale;
  }

  @override
  bool shouldReload(_AppLocalDelegate old) => true;
}

String getLang(String key) {
  return AppLocale.of(CustomNavigator.navigatorState.currentContext!).getTranslated(key);
}

String currentLang() => CustomNavigator.navigatorState.currentContext != null ? AppLocale.of(CustomNavigator.navigatorState.currentContext!).locale.languageCode : "en";
