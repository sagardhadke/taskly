import 'package:flutter/material.dart';
import 'package:taskly/core/database/note_database.dart';

class ListProvider extends ChangeNotifier {
  List<Map<String, dynamic>> allNotes = [];

  Future<void> fetchAllNote() async {
    DBHelper getDb = DBHelper.getInstance;
    allNotes = await getDb.getAllNote();
    notifyListeners();
  }

  void addNote({required String title, required String desc}) async {
    DBHelper getDB = DBHelper.getInstance;
    await getDB.addNote(title: title, desc: desc);
    // notifyListeners();
    await fetchAllNote();
  }

  void updateNote({
    required String title,
    required String desc,
    required int noteId,
  }) async {
    DBHelper getDB = DBHelper.getInstance;
    await getDB.updateNote(title: title, desc: desc, noteId: noteId);
    // notifyListeners();
    await fetchAllNote();
  }

  void deleteNote({required int noteId}) async {
    DBHelper getDb = DBHelper.getInstance;
    await getDb.deleteNote(noteId: noteId);
    // notifyListeners();
    await fetchAllNote();
  }
}
