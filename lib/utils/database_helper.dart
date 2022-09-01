// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:notes_flutter/models/note.dart';
//
// class DatabaseHelper {
//   //db name and columns
//   String noteTable = "note_table";
//   String id = "id";
//   String title = "title";
//   String content = "content";
//   String time = "time";
//   static late Database _database;
//
//   static late DatabaseHelper _databaseHelper;
//
//   DatabaseHelper._privateConstructor();
//   factory DatabaseHelper(){
//     return _databaseHelper = DatabaseHelper._privateConstructor();
//   }
//
//   //db helper singleton instance
//   // DatabaseHelper._createInstance();
//   // factory DatabaseHelper() =>
//   //     _databaseHelper ??= DatabaseHelper._createInstance();
//
//   //db getter
//   Future<Database> get database async {
//     if(database != null) return database ;
//     return await initDatabase();
//   }
//
//   // initialize the path of the db
//   Future<Database> initDatabase() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = "${directory.path}notes.db";
//     var notesDb =
//         await openDatabase(path, version: 1, onCreate: _createDatabase);
//     return notesDb;
//   }
//
//   //create database
//   void _createDatabase(Database db, int version) async {
//     await (db.execute(
//         "CREATE TABLE $noteTable($id INTEGER PRIMARY KEY AUTOINCREMENT, $title TEXT, $content TEXT, $time TEXT ) "));
//   }
//
//   //get data
//   Future<List<Map<String, dynamic>>> getAllNotes() async {
//     Database db = await database;
//     var result = await db.rawQuery("SELECT * FROM $noteTable"); //raw query
//     //var result = db.query(noteTable, orderBy: "$title ASC");  //query method
//     return result;
//   }
//
//   //insert data
//   Future<int> insertNote(Note note) async {
//     Database db = await database;
//     int result = await db.insert(noteTable, note.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
//     debugPrintStack(label: "Note inserted");
//     return result;
//   }
//
//   //update data
//   Future<int> updateNote(Note note) async {
//     Database db = await database;
//     int result = await db.update(noteTable, note.toMap(),
//         where: "$id = ?",
//         whereArgs: [note.id],
//         conflictAlgorithm: ConflictAlgorithm.replace);
//     debugPrintStack(label: "Note updated");
//     return result;
//   }
//
//   //delete data
//   Future<int> deleteNote(int noteId) async {
//     Database db = await database;
//     int result =
//         await db.rawDelete("DELETE FROM $noteTable WHERE $id = $noteId ");
//     debugPrintStack(label: "Note deleted");
//     return result;
//   }
//
//   //get no of objects in the database
//   Future<int?> getCount() async {
//     Database db = await database;
//     List<Map<String, dynamic>> x =
//         await db.rawQuery("SELECT COUNT (*) FROM $noteTable");
//     int? count = Sqflite.firstIntValue(x);
//     return count;
//   }
//
//   Future<List<Note>> getNoteList() async {
//     var noteMap = await getAllNotes();
//     List<Note> noteList = <Note>[];
//     for(int i = 0 ; i < noteMap.length ; i++){
//       noteList.add(Note.fromMapObject(noteMap[i]));
//     }
//     return noteList;
//   }
// }
