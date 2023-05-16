import 'package:flutter/material.dart';
import 'package:simple_notes_app/models/note.dart';
import 'package:simple_notes_app/services/notes_database.dart';

class NoteDatabaseProvider extends ChangeNotifier {
  List<Note> mainList = [];

  Color? addedColor;
  int selectedIndex = 0;
  Color clr = Colors.grey;

  void addColor(Color color) {
    addedColor = color;
    notifyListeners();
  }

  void toggleColor() {
    clr = Colors.white;
    notifyListeners();
  }

  void toggleSelect(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Future insertNote(Note note) async {
    await NotesDatabase.instance.insert(note);
  }

  Future queryAllNote() async {
    mainList = await NotesDatabase.instance.queryAll();
    notifyListeners();
  }

  Future updateTask(Note note) async {
    await NotesDatabase.instance.update(note);
  }

  Future deleteTask(Note note) async {
    await NotesDatabase.instance.delete(note);
  }
}
