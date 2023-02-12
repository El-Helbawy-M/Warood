import 'package:flutter_bloc/src/bloc_provider.dart' show BlocProvider, BlocProviderSingleChildWidget;
import 'package:flutter_project_base/base/blocs/settings_bloc.dart';
import 'package:flutter_project_base/services/home/Blocs/home_bloc.dart';
import 'package:flutter_project_base/services/home/Blocs/pray_check_bloc.dart';
import 'package:flutter_project_base/services/home/Blocs/pray_time_bloc.dart';

abstract class ProviderList {
  static List<BlocProviderSingleChildWidget> providers = [
    BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
    BlocProvider(create: (context) => PrayTimeBloc()),
    BlocProvider(create: (context) => PrayCheckBloc()),
    BlocProvider(create: (context) => SettingsBloc()),
  ];
}
