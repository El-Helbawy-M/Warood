import 'package:flutter_project_base/base/models/pray_model.dart';
import 'package:flutter_project_base/config/database_table_names.dart';
import 'package:flutter_project_base/utilities/extensions/date_time_values.dart';

import '../../../debug/log_printer.dart';
import '../../../handlers/local_database_hendler.dart';

class PraysChecksRepo {
  List<DayPraysModel> days = [];
  int indexOf(DateTime date) {
    for (int index = 0; index < days.length; index++) {
      if (days[index].day == date.day && days[index].month == date.getMonth && days[index].year == date.getYear) {
        log_data(label: "Check", data: "${days[index].day}:${date.day}\n${days[index].month}:${date.getMonth}\n${days[index].year}:${date.getYear}");
        return index;
      }
    }
    return -1;
  }

  bool contain(int day, String month, String year) {
    for (int index = 0; index < days.length; index++) {
      if (days[index].day == day && days[index].month == month && days[index].year == year) {
        log_data(label: "Check", data: "${days[index].day}:${day}\n${days[index].month}:${month}\n${days[index].year}:${year}");
        return true;
      }
    }
    return false;
  }

  Future<List<DayPraysModel>> getDays() async {
    days = (await LocaleDatabaseHadnler.localDatabaseHelper.getEntities(opjectModel: DayPraysModel(), tableName: TablesNames().praysTable)).cast<DayPraysModel>();
    return days;
  }

  Future<List<DayPraysModel>> addDay({required DateTime date}) async {
    DayPraysModel day = DayPraysModel.init(day: date.day, month: date.getMonth, year: date.getYear);
    (await LocaleDatabaseHadnler.localDatabaseHelper.insertEntity(tableName: TablesNames().praysTable, opject: day));
    days.add(day);
    return days;
  }
}
