// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'locale_database_model_mapper.dart';

class LocaleDatabaseHelper {
  static LocaleDatabaseHelper localDatabaseHelper = LocaleDatabaseHelper._internal();
  LocaleDatabaseHelper._internal();
  late Database database;
  Future<void> initDatabase({String? intialTableName}) async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE ${intialTableName??"Items"}(id TEXT PRIMARY KEY, title TEXT, image TEXT, price DOUBLE, type TEXT, author TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertEntity({required String tableName,required DatabaseModelMapper opject})async {
    await database.insert(
      tableName,
      opject.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteEntity({required String id,required String tableName}) async {
    await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<DatabaseModelMapper>> getEntities({required DatabaseModelMapper opjectModel,required String tableName}) async{
    final List<DatabaseModelMapper> models = (await database.query(tableName)).map((map) => opjectModel.fromMap(map)).toList();
    return models;
  }
}