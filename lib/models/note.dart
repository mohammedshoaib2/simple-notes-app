import 'package:flutter/material.dart';
import 'package:simple_notes_app/models/note_fileds.dart';

class Note {
  final int? id;
  final String title;
  final String description;
  final DateTime time;
  final Color color;

  Note(
      {this.id,
      required this.title,
      required this.description,
      required this.time,
      required this.color});

  Map<String, dynamic> toJson() {
    return {
      NoteDatabaseFields.title: title,
      NoteDatabaseFields.description: description,
      NoteDatabaseFields.time: time.toIso8601String(),
      NoteDatabaseFields.color: color.toString(),
    };
  }

  static Note fromJson(Map<String, dynamic> mapJson) {
    String colorString =
        mapJson[NoteDatabaseFields.color].split('(0x')[1].split(')')[0];
    return Note(
        id: mapJson[NoteDatabaseFields.id] as int,
        title: mapJson[NoteDatabaseFields.title] as String,
        description: mapJson[NoteDatabaseFields.description] as String,
        time: DateTime.parse(mapJson[NoteDatabaseFields.time] as String),
        color: Color(int.parse(colorString, radix: 16)));
  }
}
