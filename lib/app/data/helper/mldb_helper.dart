import 'package:note_app_pro/app/data/model/list_model.dart';
import 'package:note_app_pro/app/data/model/schedule_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class MLDBHelper {
  static Database _db;
  static final int _version = 1;
  static final String _tableName = '_listDB';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = await getDatabasesPath();
      String path1 = p.join(path,'_listDB.db');
      _db = await openDatabase(
        path1,
        version: _version,
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY,color STRING,title STRING)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<void> createDb(String nameTable) async {
    _db.execute('CREATE TABLE $nameTable(id INTEGER PRIMARY KEY,isScheduled INTEGER,title STRING,momentOfReminding STRING,focusNode STRING,dateTime STRING, note TEXT)');
  }

  static Future<int> insertList(ListModel listModel) async {
    return await _db.insert(_tableName, listModel.toMap());
  }

  static Future<int> deleteItemList(ListModel listModel) async {
    return await _db
        .delete(_tableName, where: 'id = ?', whereArgs: [listModel.id]);
  }

  static Future<int> updateItemList(ListModel listModel) async {
    return await _db.update(_tableName, listModel.toMap(),
        where: 'id = ?', whereArgs: [listModel.id]);
  }

  static Future<List<Map<String, dynamic>>> queryList() async {
    return _db.query(_tableName);
  }

  static Future<int> insert(String tableName,ScheduleModel scheduleModel) async {
    return await _db.insert(tableName, scheduleModel.toJson());
  }

  static Future<int> delete(String tableName,ScheduleModel scheduleModel) async {
    return await _db.delete(tableName, where: 'id = ?', whereArgs: [scheduleModel.id]);
  }

  static Future<int> update(String tableName,ScheduleModel scheduleModel) async {
    return await _db.update(tableName,scheduleModel.toJson(),where: 'id = ?',whereArgs: [scheduleModel.id]);
  }


  static Future<List<Map<String, dynamic>>> query(String tableName) async {
    return _db.query(tableName);
  }
}
