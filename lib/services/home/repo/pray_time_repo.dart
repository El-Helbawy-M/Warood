import 'package:flutter_project_base/config/api_names.dart';
import 'package:flutter_project_base/network/network_handler.dart';
import 'package:geolocator/geolocator.dart';

import '../models/network_models/prayer_time_model.dart';

class PrayTimeRepo {
  Future<PrayerTimeModel?> getTime(Position position) async {
    Map<String, dynamic>? response = await NetworkHandler.instance!.get(url: ApiNames().prayeTime, query: position.toJson());
    if (response != null) {
      return PrayerTimeModel.fromJson(response);
    } else {
      return null;
    }
  }
}
