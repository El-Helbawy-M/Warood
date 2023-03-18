import 'package:flutter_bloc/src/bloc_provider.dart' show BlocProvider, BlocProviderSingleChildWidget;
import 'package:flutter_project_base/base/blocs/settings_bloc.dart';
import 'package:flutter_project_base/base/blocs/user_bloc.dart';
import 'package:flutter_project_base/config/app_events.dart';
import 'package:flutter_project_base/services/home/Blocs/home_bloc.dart';
import 'package:flutter_project_base/services/home/Blocs/pray_check_bloc.dart';
import 'package:flutter_project_base/services/home/Blocs/pray_time_bloc.dart';

import '../services/trace_schedule/bloc/schedule_prays_checks_bloc.dart';

abstract class ProviderList {
  static List<BlocProviderSingleChildWidget> providers = [
    BlocProvider(create: (context) => SettingsBloc()),
    BlocProvider(create: (context) => HomeBloc()),
    BlocProvider(create: (context) => PrayTimeBloc()..add(Get())),
    BlocProvider(create: (context) => PrayCheckBloc()..add(Init())),
    BlocProvider(create: (context) => UserBloc()..add(Get())),
    BlocProvider(create: (context) => SchedulePraysChecksBloc()..add(Get())),
  ];
}
