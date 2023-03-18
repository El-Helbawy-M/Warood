import 'package:flutter_project_base/config/api_names.dart';
import 'package:flutter_project_base/network/network_handler.dart';
import 'package:flutter_project_base/utilities/extensions/date_time_values.dart';
import 'package:geolocator/geolocator.dart';
import '../models/prayer_time_model.dart';

class PrayTimeRepo {
  Future<PrayerTimeModel?> getTime(Position position) async {
    Map<String, dynamic>? response = await NetworkHandler.instance!.get(url: ApiNames().prayeTime(DateTime.now().getDate), query: position.toJson());
    if (response != null) {
      return PrayerTimeModel.fromJson(response);
    } else {
      return null;
    }
  }
}
