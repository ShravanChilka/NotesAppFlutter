import 'dart:async';
import 'package:notes_flutter/models/notes_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
  static Database? myDatabase;
  static String tableName = "notes_table";

  MyDatabase() {
    if (myDatabase != null) return;
    init();
  }

  static void init() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, "my_database.db");
    myDatabase = await openDatabase(path, version: 3, onCreate: createDb);
  }

  static FutureOr<void> createDb(Database db, int version) {
    return db.execute(
        "CREATE TABLE ${MyDatabase.tableName} (id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, content STRING, time STRING )");
  }

  static Future<int?> insertNote(MyNotes myNotes) async {
    MyDatabase.init();
    int? result = await myDatabase?.insert(tableName, myNotes.toMap());
    return result;
  }

  static Future<List<MyNotes>?> getAll() async {
    List<Map<String, Object?>>? mapList = await myDatabase?.query(tableName);
    return mapList?.map((map) => MyNotes.fromMap(map)).toList();
  }

  static Future<int?> deleteNote(MyNotes notes) async {
    int? result = await myDatabase?.delete(tableName, where: "id = ?", whereArgs: [notes.id]);
    return result;
  }

  static Future<int?> updateNote(MyNotes notes) async {
    MyDatabase.init();
    int? result = await myDatabase?.update(tableName,notes.toMap(), where: 'id = ?' , whereArgs: [notes.id]);
    return result;
  }

}
