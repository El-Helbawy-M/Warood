import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/base/widgets/reward_bottomsheet.dart';
import 'package:flutter_project_base/debug/log_printer.dart';
import 'package:flutter_project_base/routers/navigator.dart';
import 'package:flutter_project_base/base/models/pray_model.dart';
import 'package:flutter_project_base/services/home/repo/pray_check_repo.dart';
import 'package:flutter_project_base/services/trace_schedule/bloc/schedule_prays_checks_bloc.dart';
import '../../../config/app_events.dart';
import '../../../config/app_states.dart';
import '../core/reward_controller.dart';

class PrayCheckBloc extends Bloc<AppEvents, AppStates> {
  PrayCheckBloc() : super(Start()) {
    on<Init>(_init);
    on<UpdateData>(_checkPray);
    on<UpdateView>(_updateView);
  }
  static PrayCheckBloc get instance => BlocProvider.of(CustomNavigator.navigatorState.currentContext!);
  DayPraysModel? model;

  //========================================
  //========================================
  //======================================== Functions

  Future<void> _checkPray(AppEvents events, Emitter emit) async {
    emit(Loading());
    try {
      Pray pray = events.arguments["pray"];
      DateTime date = events.arguments["date"];
      DayPraysModel dataModel = events.arguments["model"] ?? model;
      await PrayCheckRepo.checkPray(pray: pray, model: dataModel, date: date);
      bool check = await PrayCheckRepo.checkReward(date);
      if (check) {
        RewardController controller = RewardController();
        RewardController().setReward();
        showModalBottomSheet(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          context: CustomNavigator.navigatorState.currentContext!,
          builder: (context) => RewardBottomSheet(
            mainText: controller.isThereNewReward ? "🎉 ورده جديدة 🎉" : "مبروك",
            subText: controller.isThereNewReward ? "مبارك لك, كسبت وردة جديدة ✨" : "",
            imageName: (controller.getRewardIndex() + 1).toString(),
          ),
        );
      }
      await _getPrays();
      emit(Done(data: model));
      SchedulePraysChecksBloc.instance.add(UpdateData(arguments: date));
    } catch (e) {
      emit(Error());
    }
  }

  Future<void> _init(AppEvents event, Emitter emit) async {
    emit(Loading());
    try {
      await _getPrays();
      if (model != null) {
        emit(Done(data: model));
      } else {
        emit(Empty());
      }
      // throw (Exception("null"));
    } catch (e) {
      log_error(type: "Data base error", message: e.toString());
      emit(Error());
    }
  }

  Future<void> _getPrays() async => model = await PrayCheckRepo.getPrays();

  void _updateView(AppEvents event, Emitter emit) async {
    emit(Done(data: model));
  }
}

enum Pray { fajr, dhuhr, asr, maghrib, isha }
