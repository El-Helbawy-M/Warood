import 'local_mapper.dart';

class DayPraysModel extends LocaleSingleMapper {
  String? fajrCheckDate, dhuhrCheckDate, asrCheckDate, maghribCheckDate, ishaCheckDate;
  late final String month, year;
  late final int day;
  bool? fajrCheck, dhuhrCheck, asrCheck, maghribCheck, ishaCheck;
  List<bool> checks = [false, false, false, false, false];
  List<String> checksDates = ["", "", "", "", ""];
  int checkedPraysNum = 0;
  bool get allPraysIsChecked => (fajrCheck ?? false) && (dhuhrCheck ?? false) && (asrCheck ?? false) && (maghribCheck ?? false) && (ishaCheck ?? false);
  DayPraysModel();
  DayPraysModel.fromMap({
    required this.day,
    required this.month,
    required this.year,
    required this.fajrCheck,
    required this.fajrCheckDate,
    required this.dhuhrCheck,
    required this.dhuhrCheckDate,
    required this.asrCheck,
    required this.asrCheckDate,
    required this.ishaCheck,
    required this.ishaCheckDate,
    required this.maghribCheck,
    required this.maghribCheckDate,
  }) {
    if (fajrCheck ?? false) {
      checkedPraysNum++;
    }
    if (dhuhrCheck ?? false) {
      checkedPraysNum++;
    }
    if (asrCheck ?? false) {
      checkedPraysNum++;
    }
    if (maghribCheck ?? false) {
      checkedPraysNum++;
    }
    if (ishaCheck ?? false) {
      checkedPraysNum++;
    }
    checks = [fajrCheck ?? false, dhuhrCheck ?? false, asrCheck ?? false, maghribCheck ?? false, ishaCheck ?? false];
    checksDates = [fajrCheckDate ?? "", dhuhrCheckDate ?? "", asrCheckDate ?? "", maghribCheckDate ?? "", ishaCheckDate ?? ""];
  }
  DayPraysModel.init({required this.day, required this.month, required this.year});
  @override
  LocaleSingleMapper fromMap(Map<String, dynamic> json) {
    return DayPraysModel.fromMap(
      day: json["day"],
      month: json["month"],
      year: json["year"],
      fajrCheck: json["fajr_check"] == 1 ? true : false,
      fajrCheckDate: json["fajr_check_date"],
      dhuhrCheck: json["dhuhr_check"] == 1 ? true : false,
      dhuhrCheckDate: json["dhuhr_check_date"],
      asrCheck: json["asr_check"] == 1 ? true : false,
      asrCheckDate: json["asr_check_date"],
      ishaCheck: json["isha_check"] == 1 ? true : false,
      ishaCheckDate: json["isha_check_date"],
      maghribCheck: json["maghrib_check"] == 1 ? true : false,
      maghribCheckDate: json["maghrib_check_date"],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {};
    json["day"] = day;
    json["month"] = month;
    json["year"] = year;
    json["fajr_check"] = (fajrCheck ?? false) ? 1 : 0;
    json["fajr_check_date"] = fajrCheckDate;
    json["dhuhr_check"] = (dhuhrCheck ?? false) ? 1 : 0;
    json["dhuhr_check_date"] = dhuhrCheckDate;
    json["asr_check"] = (asrCheck ?? false) ? 1 : 0;
    json["asr_check_date"] = asrCheckDate;
    json["isha_check"] = (ishaCheck ?? false) ? 1 : 0;
    json["isha_check_date"] = ishaCheckDate;
    json["maghrib_check"] = (maghribCheck ?? false) ? 1 : 0;
    json["maghrib_check_date"] = maghribCheckDate;
    return json;
  }
}
