import 'package:flutter_project_base/handlers/local_database_hendler.dart';
import 'package:flutter_project_base/services/home/Blocs/pray_check_bloc.dart';
import 'package:intl/intl.dart';

import '../../../config/database_table_names.dart';
import '../models/core_models/pray_model.dart';

abstract class PrayCheckRepo {
  static Future<void> checkPray({required Pray pray, required DayPraysModel model, required DateTime date}) async {
    switch (pray) {
      case Pray.fajr:
        model.fajrCheck = true;
        model.fajrCheckDate = DateFormat("yMMMMd").format(date);
        break;
      case Pray.dhuhr:
        model.dhuhrCheck = true;
        model.dhuhrCheckDate = DateFormat("yMMMMd").format(date);
        break;
      case Pray.asr:
        model.asrCheck = true;
        model.asrCheckDate = DateFormat("yMMMMd").format(date);
        break;
      case Pray.maghrib:
        model.maghribCheck = true;
        model.maghribCheckDate = DateFormat("yMMMMd").format(date);
        break;
      case Pray.isha:
        model.ishaCheck = true;
        model.ishaCheckDate = DateFormat("yMMMMd").format(date);
        break;
    }
    await LocaleDatabaseHadnler.localDatabaseHelper.update(whereList: ['day', 'month', 'year'], whereData: [model.day, model.month, model.year], opjectModel: model, tableName: TablesNames().praysTable);
  }

  static Future<DayPraysModel> getPrays() async {
    String month = DateFormat("MMMM").format(DateTime.now());
    String day = DateFormat("EEEE").format(DateTime.now());
    String year = DateFormat("y").format(DateTime.now());
    bool value = await LocaleDatabaseHadnler.localDatabaseHelper.contains(whereList: ['day', 'month', 'year'], whereData: [day, month, year], tableName: TablesNames().praysTable);
    if (value) {
      DayPraysModel model = await LocaleDatabaseHadnler.localDatabaseHelper.getEntity(whereList: ['day', 'month', 'year'], whereData: [day, month, year], opjectModel: DayPraysModel(), tableName: TablesNames().praysTable) as DayPraysModel;
      return model;
    } else {
      DayPraysModel model = DayPraysModel.init(day: day, month: month, year: year);
      await LocaleDatabaseHadnler.localDatabaseHelper.insertEntity(tableName: TablesNames().praysTable, opject: model);
      return model;
    }
  }
}
