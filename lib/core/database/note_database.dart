import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskly/core/constants/table_keys.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper getInstance = DBHelper._();

  Database? myDB;

  Future<Database> initDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await openDB();
      return myDB!;
    }
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "tasklyNote.db");
    return await openDatabase(
      dbPath,
      onCreate: (db, version) {
        db.execute(
          "create table ${TableKeys.noteTable} { ${TableKeys.noteId} integer primary key autoincrement, ${TableKeys.noteTitle} text, ${TableKeys.noteDescription} text, ${TableKeys.noteCreatedAt} text }",
        );
      },
      version: 1,
    );
  }

  //*create note
  Future<bool> addNote({required String title, required String desc}) async {
    Database db = await initDB();
    int rowsEffected = await db.insert(TableKeys.noteTable, {
      TableKeys.noteTitle: title.trim(),
      TableKeys.noteDescription: desc.trim(),
      TableKeys.noteCreatedAt: DateTime.now().millisecondsSinceEpoch,
    });
    return rowsEffected > 0;
  }

  //* read all notes
  Future<List<Map<String, dynamic>>> getAllNote() async {
    Database db = await initDB();
    List<Map<String, dynamic>> mNotes = await db.query(TableKeys.noteTable);
    return mNotes;
  }

  //* Update Note
  Future<bool> updateNote({
    required String title,
    required String desc,
    required int noteId,
  }) async {
    Database db = await initDB();
    int rowsEffected = await db.update(
      TableKeys.noteTable,
      {
        TableKeys.noteTitle: title.trim(),
        TableKeys.noteDescription: desc.trim(),
      },
      where: "${TableKeys.noteId} = ?",
      whereArgs: ["$noteId"],
    );
    return rowsEffected > 0;
  }

  //* delete note
  Future<bool> deleteNote({required int noteId}) async {
    Database db = await initDB();
    int rowsEffected = await db.delete(
      TableKeys.noteTable,
      where: "${TableKeys.noteId} = ?",
      whereArgs: ['$noteId'],
    );
    return rowsEffected > 0;
  }
}
