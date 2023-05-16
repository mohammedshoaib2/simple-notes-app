// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:simple_notes_app/constants.dart';
import 'package:simple_notes_app/models/note.dart';
import 'package:simple_notes_app/screens/view_notes_screen.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime time;
  final Color color;
  final Note note;
  final int index;

  const NoteCard(
      {super.key,
      required this.title,
      required this.description,
      required this.time,
      required this.color,
      required this.note,
      required this.index});

  String formatDate() {
    return DateFormat.yMMMMd().format(time);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(context, MaterialPageRoute(builder: (builder) {
          return ViewNotesScreen(
            title: title,
            desc: description,
            time: formatDate(),
            index: index,
            color: color,
            note: note,
          );
        }));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        constraints: BoxConstraints(
          minHeight: 150.h,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: kTextStyle,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              formatDate(),
              style: kTextStyle.copyWith(
                  fontSize: 15.sp,
                  color: Colors.black26,
                  fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ),
    );
  }
}
