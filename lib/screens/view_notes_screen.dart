// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/constants.dart';
import 'package:simple_notes_app/models/note_data_provider.dart';
import 'package:simple_notes_app/screens/add_or_edit_screen.dart';
import 'package:simple_notes_app/screens/home_screen.dart';
import 'package:simple_notes_app/widgets/bottom_bar_button.dart';
import 'package:simple_notes_app/widgets/custom_button.dart';

import '../models/note.dart';

class ViewNotesScreen extends StatelessWidget {
  final String title;
  final String desc;
  final String time;
  final int index;
  final Color color;
  final Note note;

  const ViewNotesScreen({
    super.key,
    required this.title,
    required this.desc,
    required this.time,
    required this.index,
    required this.color,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                    icon: Icons.arrow_back_ios_new_outlined,
                    onTap: () {
                      Navigator.pop(context);
                    }),
                Row(
                  children: [
                    CustomButton(
                        icon: Icons.delete,
                        onTap: () async {
                          showModalBottomSheet(
                              context: context,
                              builder: (builder) {
                                return Container(
                                  color: Colors.transparent,
                                  height: 200.h,
                                  child: Container(
                                    padding: EdgeInsets.all(25.h),
                                    height: 200.h,
                                    width: 200.h,
                                    decoration: BoxDecoration(
                                        color: kBackgroundColor,
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25.r))),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Delete this note?',
                                          style: kTextStyle.copyWith(
                                              color: kWhiteColor,
                                              fontWeight: FontWeight.w100),
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            BottomBarButton(
                                                tile: 'Cancel',
                                                onTap: () {
                                                  Navigator.pop(context);
                                                }),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            BottomBarButton(
                                              tile: 'Delete',
                                              onTap: () async {
                                                await Provider.of<
                                                            NoteDatabaseProvider>(
                                                        context,
                                                        listen: false)
                                                    .deleteTask(note);

                                                Navigator.pushAndRemoveUntil(
                                                    context, MaterialPageRoute(
                                                        builder: (builder) {
                                                  return const HomeScreen();
                                                }), (route) => false);
                                              },
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }),
                    SizedBox(
                      width: 15.w,
                    ),
                    CustomButton(
                        icon: Icons.edit,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (builder) {
                            return AddOrEditScreen(
                              isForEdit: true,
                              note: note,
                            );
                          }));
                        }),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: color,
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView(
                      children: [
                        SelectableText(
                          title,
                          style: kTextStyle.copyWith(
                              color: Colors.black54,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          time,
                          style: kTextStyle.copyWith(
                              color: Colors.black54,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SelectableText(
                          desc,
                          style: kTextStyle.copyWith(
                              color: Colors.black54,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
