import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/config/app_events.dart';
import 'package:flutter_project_base/config/app_states.dart';
import 'package:flutter_project_base/routers/navigator.dart';
import 'package:flutter_project_base/services/home/Blocs/pray_check_bloc.dart';
import 'package:flutter_project_base/services/home/core/clock_time_controller.dart';
import 'package:flutter_project_base/services/trace_schedule/bloc/schedule_prays_checks_bloc.dart';

class HomeBloc extends Cubit<AppStates> {
  HomeBloc() : super(Start()) {
    clockController = ClockTimeController();
    clockController.start(onTimeChange: _changeTime);
  }
  String currentPrayTime = "00:00";
  static HomeBloc get instance => BlocProvider.of(CustomNavigator.navigatorState.currentContext!);
  // Veriables
  late final ClockTimeController clockController;
  @override
  Future<void> close() {
    clockController.timer!.cancel();
    return super.close();
  }

  void _changeTime() {
    emit(Done());
    PrayCheckBloc.instance.add(UpdateView());
    SchedulePraysChecksBloc.instance.add(UpdateView());
  }
}
