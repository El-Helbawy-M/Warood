import 'dart:convert';

import 'package:flutter_project_base/base/models/mapper.dart';

class UserModel extends SingleMapper {
  // veriables
  late final Map<String, int>? rewards;
  late final int indexOfNextRewardToUnlock, progressToUnlock;

  // constructors
  UserModel.formJson(Map json) {
    rewards = (json.cast<String, int>());
    _detectTheNextReward();
  }

  // functions
  void _detectTheNextReward() {
    int latestReward = rewards!.length == 0 ? 1 : rewards!.length;
    progressToUnlock = rewards![latestReward - 1] ?? 0;
    indexOfNextRewardToUnlock = latestReward;
  }

  Map toMap() {
    return rewards ?? {};
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return UserModel.formJson(json);
  }
}
