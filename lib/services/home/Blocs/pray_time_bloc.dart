import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/config/app_events.dart';
import 'package:flutter_project_base/config/app_states.dart';
import 'package:flutter_project_base/debug/log_printer.dart';
import 'package:flutter_project_base/handlers/geolocator_handler.dart';
import 'package:flutter_project_base/routers/navigator.dart';
import 'package:flutter_project_base/services/home/repo/pray_time_repo.dart';
import 'package:geolocator/geolocator.dart';
import '../models/prayer_time_model.dart';

class PrayTimeBloc extends Bloc<AppEvents, AppStates> {
  PrayTimeBloc() : super(Start()) {
    on<Get>(_get);
  }
  static PrayTimeBloc get instance => BlocProvider.of(CustomNavigator.navigatorState.currentContext!);

  Future<PrayerTimeModel?> _getTime() async {
    try {
      Position? position = await GeolocatorHandler().getLocation();
      if (position != null) {
        return await PrayTimeRepo().getTime(position);
      } else {
        return null;
      }
    } catch (e) {
      if (e.toString() == "No Location") {
        log_error(type: "Location Error", message: "No Location", hint: "request from the user to enable the location");
      }
      rethrow;
    }
  }

  Future<void> _get(AppEvents event, Emitter<AppStates> emit) async {
    emit(Loading());
    try {
      PrayerTimeModel? model = await _getTime();

      if (model != null) {
        log_data(label: "Pray Timing normal", data: model.date!.readable ?? "");
        log_data(label: "Pray Timing hijiri", data: model.date!.hijri!.date ?? "");
        emit(Done(model: model));
      } else {
        emit(Empty());
      }
    } catch (e) {
      if (e.toString() == "No Location") {
        emit(Error());
      } else {
        emit(NoLocation());
      }
    }
  }
}
