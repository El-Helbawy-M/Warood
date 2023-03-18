import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/config/app_events.dart';
import 'package:flutter_project_base/config/app_states.dart';
import 'package:flutter_project_base/debug/log_printer.dart';
import 'package:flutter_project_base/routers/navigator.dart';
import 'package:flutter_project_base/services/trace_schedule/repo/prays_check_repo.dart';
import 'package:flutter_project_base/utilities/components/custom_snack_bar.dart';

class SchedulePraysChecksBloc extends Bloc<AppEvents, AppStates> {
  SchedulePraysChecksBloc() : super(Loading()) {
    on<Get>(_getPrays);
    on<GetDay>(_getPraysOf);
    on<UpdateData>(_updateDataOf);
    on<UpdateView>(_updateView);
  }

  PraysChecksRepo repo = PraysChecksRepo();
  int selectedDate = 0;
  DateTime selectedDateTime = DateTime.now();
  static SchedulePraysChecksBloc get instance => BlocProvider.of(CustomNavigator.navigatorState.currentContext!);
  //==========================================
  //==========================================
  //========================================== Functions
  Future<void> _getPrays(AppEvents event, Emitter emit) async {
    emit(Loading());
    try {
      await repo.getDays();
      if (repo.days.isNotEmpty) {
        log_data(label: "label", data: repo.days.length);
        selectedDate = repo.indexOf(DateTime.now());
        emit(Done(data: repo.days[selectedDate]));
      } else {
        selectedDate = -1;
        emit(Empty());
      }
    } catch (e) {
      emit(Error());
      showSnackBar(content: e.toString());
    }
  }

  Future<void> _getPraysOf(AppEvents event, Emitter emit) async {
    emit(Loading());
    int index = repo.indexOf(event.arguments as DateTime);
    selectedDateTime = event.arguments as DateTime;
    if (index != -1) {
      emit(Done(data: repo.days[index]));
    } else {
      repo.days = await repo.addDay(date: event.arguments as DateTime);
      index = repo.indexOf(event.arguments as DateTime);
      log_data(label: "day index", data: index);
      emit(Done(data: repo.days[index]));
    }
    selectedDate = index;
  }

  Future<void> _updateDataOf(AppEvents event, Emitter emit) async {
    await repo.getDays();
    int index = repo.indexOf(event.arguments as DateTime);
    log_data(label: "index of day", data: repo.days[index].checks);
    selectedDateTime = event.arguments as DateTime;
    if (index != -1) {
      emit(Done(data: repo.days[index]));
    } else {
      repo.days = await repo.addDay(date: event.arguments as DateTime);
      index = repo.indexOf(event.arguments as DateTime);
      log_data(label: "day index", data: index);
      emit(Done(data: repo.days[index]));
    }
    selectedDate = index;
  }

  void _updateView(AppEvents event, Emitter emit) {
    emit(Done(data: repo.days[selectedDate]));
  }
}
