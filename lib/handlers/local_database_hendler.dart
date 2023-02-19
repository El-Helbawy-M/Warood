import 'dart:developer';

import 'package:flutter_project_base/debug/log_printer.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../base/models/local_mapper.dart';

class LocaleDatabaseHadnler {
  static LocaleDatabaseHadnler localDatabaseHelper = LocaleDatabaseHadnler._internal();
  LocaleDatabaseHadnler._internal();
  late Database database;
  String _generateWhereClause(List<String> whereList) {
    String whereCluse = "";
    for (int x = 0; x < whereList.length; x++) {
      if (x == 0) {
        whereCluse += "${whereList[x]} = ? ";
      } else {
        whereCluse += "AND ${whereList[x]} = ?";
      }
    }
    return whereCluse;
  }

  Future<void> initDatabase({String? intialTableName}) async {
    localDatabaseHelper.database = await openDatabase(
      join(await getDatabasesPath(), 'pray_checks.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE Rewards(day TEXT, month TEXT, year TEXT, rewardId INTEGER, PRIMARY KEY (day, month, year))',
        );
        return db.execute(
          'CREATE TABLE ${intialTableName ?? "Items"}(day TEXT, month TEXT, year TEXT, fajr_check INTEGER, fajr_check_date TEXT, dhuhr_check INTEGER, dhuhr_check_date TEXT, asr_check INTEGER, asr_check_date TEXT, isha_check INTEGER, isha_check_date TEXT, maghrib_check INTEGER, maghrib_check_date TEXT, PRIMARY KEY (day, month, year))',
        );
      },
      version: 1,
    );
  }

  Future<void> insertEntity({required String tableName, required LocaleSingleMapper opject}) async {
    await database.insert(
      tableName,
      opject.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteEntity({required String tableName, required List<String> whereList, required List<dynamic> whereData}) async {
    String whereCluse = _generateWhereClause(whereList);
    await database.delete(
      tableName,
      where: whereCluse,
      whereArgs: whereData,
    );
  }

  Future<List<LocaleSingleMapper>> getEntities({required LocaleSingleMapper opjectModel, required String tableName}) async {
    final List<LocaleSingleMapper> models = (await database.query(tableName)).map((map) => opjectModel.fromMap(map)).toList();
    return models;
  }

  Future<LocaleSingleMapper?> getEntity({required List<String> whereList, required List<dynamic> whereData, required LocaleSingleMapper opjectModel, required String tableName}) async {
    String whereCluse = _generateWhereClause(whereList);
    Map<String, dynamic> data = (await database.query(tableName, where: whereCluse, whereArgs: whereData)).first;
    if (data.isNotEmpty) return opjectModel.fromMap(data);
    return null;
  }

  Future<void> update({required List<String> whereList, required List<dynamic> whereData, required LocaleSingleMapper opjectModel, required String tableName}) async {
    String whereCluse = _generateWhereClause(whereList);
    int x = (await database.update(tableName, opjectModel.toMap(), where: whereCluse, whereArgs: whereData));
    log_check(label: "Check Update response", currentValue: x, expectedValue: 1);
  }

  Future<bool> contains({required List<String> whereList, required List<dynamic> whereData, required String tableName}) async {
    String whereCluse = _generateWhereClause(whereList);
    return (await database.query(tableName, where: whereCluse, whereArgs: whereData)).isNotEmpty;
  }
}
