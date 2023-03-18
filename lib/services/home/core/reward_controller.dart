import 'package:flutter_project_base/base/blocs/user_bloc.dart';
import 'package:flutter_project_base/config/app_events.dart';
import 'package:flutter_project_base/debug/log_printer.dart';

class RewardController {
  bool _unclockedNewReward = false;
  setReward() {
    var model = UserBloc.bloc.model;
    bool isMax = (model.rewards!["image ${model.indexOfNextRewardToUnlock - 1}"] ?? 0) >= 30;
    log_data(label: "Is Max", data: isMax);
    if (isMax) {
      model.rewards!["image ${model.indexOfNextRewardToUnlock - 1}"] = 30;
      model.rewards!["image ${model.indexOfNextRewardToUnlock}"] = 1;
      model.indexOfNextRewardToUnlock++;
      _unclockedNewReward = true;
    } else {
      model.rewards!["image ${model.indexOfNextRewardToUnlock - 1}"] = (model.rewards!["image ${model.indexOfNextRewardToUnlock - 1}"] ?? 0) + 1;
    }
    UserBloc.bloc.add(UpdateData(arguments: model));
  }

  bool get isThereNewReward => _unclockedNewReward;
  getRewardIndex() => UserBloc.bloc.model.indexOfNextRewardToUnlock == 0 ? 0 : UserBloc.bloc.model.indexOfNextRewardToUnlock - 1;
}
