import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/config/app_states.dart';
import 'package:flutter_project_base/handlers/localization_handler.dart';
import 'package:flutter_project_base/routers/navigator.dart';
import 'package:flutter_project_base/services/home/core/clock_time_controller.dart';
import 'package:intl/intl.dart';
import '../../../utilities/formatters.dart';

class HomeBloc extends Cubit<AppStates> {
  HomeBloc() : super(Start()) {
    clockController = ClockTimeController();
    clockController.start(onTimeChange: _changeTime);
  }

  static HomeBloc get instance => BlocProvider.of(CustomNavigator.navigatorState.currentContext!);
  // Veriables
  late final ClockTimeController clockController;
  void _changeTime() {
    emit(
      Done(
        mapedData: {
          "clock_type": clockController.hours >= 12 ? getLang("pm") : getLang("am"),
          "clock": Formatter().clockTimeFormat(clockController.hours, clockController.minutes, clockController.seconds),
          "date": DateFormat.MMMMEEEEd().format(DateTime.now()),
        },
      ),
    );
  }
}
