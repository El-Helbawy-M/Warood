import 'package:flutter_project_base/base/models/mapper.dart';

class UserModel extends SingleMapper {
  // veriables
  late final Map<String, int>? rewards;
  int indexOfNextRewardToUnlock = -1, progressToUnlock = 0;

  // constructors
  UserModel.formJson(Map json) {
    rewards = (json.cast<String, int>());
    _detectTheNextReward();
  }

  UserModel() {
    rewards = {"image 0": 0};
    _detectTheNextReward();
  }

  // functions
  void _detectTheNextReward() {
    indexOfNextRewardToUnlock = rewards!.length;
    progressToUnlock = rewards![indexOfNextRewardToUnlock - 1] ?? 0;
  }

  Map toMap() {
    return rewards ?? {};
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return UserModel.formJson(json);
  }
}
