// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:simple_notes_app/models/note.dart';
import 'package:simple_notes_app/models/note_fileds.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class NotesDatabase {
  NotesDatabase._init();
  static final NotesDatabase instance = NotesDatabase._init();
  final String dbName = 'simpleNotes.db';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    await db.execute('''

    CREATE TABLE ${NoteDatabaseFields.tableName}(

      ${NoteDatabaseFields.id} $idType,
      ${NoteDatabaseFields.title} $textType,
      ${NoteDatabaseFields.description} $textType,
      ${NoteDatabaseFields.time} $textType,
      ${NoteDatabaseFields.color} $textType

    )



''');
  }

  Future insert(Note note) async {
    Database db = await instance.database;
    Map<String, dynamic> conMap = note.toJson();
    await db.transaction((txn) async {
      await txn.insert(NoteDatabaseFields.tableName, conMap);
    });
  }

  Future<List<Note>> queryAll() async {
    Database db = await instance.database;
    // ignore: prefer_typing_uninitialized_variables
    var result;
    await db.transaction((txn) async {
      result = await txn.query(NoteDatabaseFields.tableName);
    });

    return result
        .map((mapJson) => Note.fromJson(mapJson))
        .cast<Note>()
        .toList();
  }

  Future update(Note note) async {
    Database db = await instance.database;

    Map<String, dynamic> conMap = note.toJson();
    db.transaction((txn) async {
      await txn.update(NoteDatabaseFields.tableName, conMap,
          where: '${NoteDatabaseFields.id} = ?', whereArgs: [note.id]);
    });
  }

  Future delete(Note note) async {
    Database db = await instance.database;

    await db.transaction((txn) async {
      await txn.delete(NoteDatabaseFields.tableName,
          where: '${NoteDatabaseFields.id} = ?', whereArgs: [note.id]);
    });
  }

  Future closeDb() async {
    Database db = await instance.database;

    await db.close();
  }
}
