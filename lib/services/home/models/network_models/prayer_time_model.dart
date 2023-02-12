import 'package:flutter_project_base/base/models/mapper.dart';
import 'package:flutter_project_base/services/home/models/network_models/timings_model.dart';
import 'day_date_model.dart';

class PrayerTimeModel extends SingleMapper {
  int? code;
  String? status;
  Timings? timings;
  Date? date;
  Meta? meta;
  PrayerTimeModel({this.code, this.status});

  PrayerTimeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    timings = json['data']['timings'] != null ? Timings.fromJson(json['data']['timings']) : null;
    date = json['data']['date'] != null ? Date.fromJson(json['data']['date']) : null;
    meta = json['data']['meta'] != null ? Meta.fromJson(json['data']['meta']) : null;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return PrayerTimeModel.fromJson(json);
  }
}

class Meta {
  double? latitude;
  double? longitude;
  String? timezone;
  String? latitudeAdjustmentMethod;
  String? midnightMode;
  String? school;

  Meta({this.latitude, this.longitude, this.timezone, this.latitudeAdjustmentMethod, this.midnightMode, this.school});

  Meta.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    timezone = json['timezone'];
    latitudeAdjustmentMethod = json['latitudeAdjustmentMethod'];
    midnightMode = json['midnightMode'];
    school = json['school'];
  }
}
