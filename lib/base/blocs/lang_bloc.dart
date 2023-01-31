import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/config/app_events.dart';
import 'package:flutter_project_base/config/app_states.dart';
import 'package:flutter_project_base/handlers/localization_handler.dart';
import 'package:flutter_project_base/handlers/shared_handler.dart';
import 'package:flutter_project_base/routers/navigator.dart';
import 'package:rxdart/rxdart.dart';

class LangBloc {
  initLang() {
    String value = SharedHandler.instance!.getData(key: SharedKeys().lang, valueType: ValueType.string);
    value = value != "" ? value : "en";
    return updateLang = value;
  }

  static LangBloc get instnace => BlocProvider.of(CustomNavigator.navigatorState.currentContext!);

  final lang = BehaviorSubject<String?>();

  set updateLang(String value) {
    if (value != currentLang()) SharedHandler.instance!.setData(SharedKeys().lang, value: value);
    lang.sink.add(value);
  }

  Stream<String?> get langStream => lang.stream.asBroadcastStream();
}

LangBloc langBloc = LangBloc();
