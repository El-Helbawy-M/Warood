import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/base/blocs/user_bloc.dart';
import 'package:flutter_project_base/base/widgets/reward_dialog.dart';
import 'package:flutter_project_base/debug/log_printer.dart';
import 'package:flutter_project_base/routers/navigator.dart';
import 'package:flutter_project_base/services/home/models/core_models/pray_model.dart';
import 'package:flutter_project_base/services/home/repo/pray_check_repo.dart';

import '../../../config/app_events.dart';
import '../../../config/app_states.dart';
import '../core/reward_controller.dart';

class PrayCheckBloc extends Bloc<AppEvents, AppStates> {
  PrayCheckBloc() : super(Start()) {
    on<Init>(_init);
    on<Update>(_checkPray);
    add(Init());
  }
  static PrayCheckBloc get instance => BlocProvider.of(CustomNavigator.navigatorState.currentContext!);
  DayPraysModel? model;
  Future<void> _checkPray(AppEvents events, Emitter emit) async {
    emit(Loading());
    try {
      await PrayCheckRepo.checkPray(pray: events.arguments, model: model!, date: DateTime.now());
      bool check = await PrayCheckRepo.checkReward();
      if (check) {
        RewardController controller = RewardController();
        RewardController().setReward();
        showDialog(
          context: CustomNavigator.navigatorState.currentContext!,
          builder: (context) => RewardDialog(
            mainText: controller.isThereNewReward ? "🎉 New Reward 🎉" : "Congratulations",
            subText: controller.isThereNewReward ? "Congratulations You have unclocked a new reward" : "",
            imageName: (controller.getRewardIndex() + 1).toString(),
          ),
        );
      }
      await _getPrays();

      emit(Done(data: model));
    } catch (e) {
      emit(Error());
    }
  }

  Future<void> _init(AppEvents event, Emitter emit) async {
    emit(Loading());
    try {
      await _getPrays();
      if (model != null) emit(Done(data: model));
      // throw (Exception("null"));
    } catch (e) {
      log_error(type: "Data base error", message: e.toString());
      emit(Error());
    }
  }

  Future<void> _getPrays() async => model = await PrayCheckRepo.getPrays();
}

enum Pray { fajr, dhuhr, asr, maghrib, isha }
