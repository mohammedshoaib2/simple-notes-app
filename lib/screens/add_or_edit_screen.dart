// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/constants.dart';
import 'package:simple_notes_app/models/note.dart';
import 'package:simple_notes_app/models/note_data_provider.dart';
import 'package:simple_notes_app/screens/home_screen.dart';
import 'package:simple_notes_app/services/notes_database.dart';
import 'package:simple_notes_app/widgets/color_selector_widget.dart';
import 'package:simple_notes_app/widgets/custom_button.dart';

class AddOrEditScreen extends StatefulWidget {
  final bool? isForEdit;
  final Note? note;

  const AddOrEditScreen({super.key, this.isForEdit, this.note});

  @override
  State<AddOrEditScreen> createState() => _AddOrEditScreenState();
}

class _AddOrEditScreenState extends State<AddOrEditScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();
  bool fromEdit = false;
  Color saveButtonColor = Colors.grey;
  bool saveButtonState = false;
  bool showLoader = false;

  void closeDatabase() async {
    await NotesDatabase.instance.closeDb();
  }

  void setControllerIfEdit() async {
    if (widget.isForEdit == true) {
      titleController.text = widget.note!.title;
      descController.text = widget.note!.description;
      fromEdit = true;

      Future.delayed(
        Duration.zero,
        () {
          Provider.of<NoteDatabaseProvider>(context, listen: false)
              .toggleSelect(getIndexNumberOfColor(widget.note!.color));
        },
      );
    }
  }

  @override
  void initState() {
    setControllerIfEdit();
    super.initState();

    getBtnColor();
  }

  Color getBtnColor() {
    if (titleController.text.isNotEmpty && descController.text.isNotEmpty) {
      setState(() {
        saveButtonColor = kWhiteColor;
        saveButtonState = true;
      });
    } else {
      setState(() {
        saveButtonColor = Colors.grey;
        saveButtonState = false;
      });
    }

    return saveButtonColor;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // resizeToAvoidBottomInset: false,
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
                      Provider.of<NoteDatabaseProvider>(context, listen: false)
                          .toggleSelect(0);
                      Navigator.pop(context);
                    }),
                TextButton(
                  onPressed: saveButtonState && !showLoader
                      ? () async {
                          setState(() {
                            showLoader = true;
                          });
                          !fromEdit
                              ? await Provider.of<NoteDatabaseProvider>(context, listen: false)
                                  .insertNote(Note(
                                      title: titleController.text,
                                      description: descController.text,
                                      time: DateTime.now(),
                                      color: listOfColors[
                                          Provider.of<NoteDatabaseProvider>(
                                                  context,
                                                  listen: false)
                                              .selectedIndex]))
                              : await Provider.of<NoteDatabaseProvider>(context, listen: false)
                                  .updateTask(Note(
                                      id: widget.note!.id,
                                      title: titleController.text,
                                      description: descController.text,
                                      time: DateTime.now(),
                                      color: listOfColors[
                                          Provider.of<NoteDatabaseProvider>(
                                                  context,
                                                  listen: false)
                                              .selectedIndex]));

                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (builder) {
                            return HomeScreen();
                          }), (route) => false);

                          Future.delayed(Duration.zero, () {
                            Provider.of<NoteDatabaseProvider>(context,
                                    listen: false)
                                .toggleSelect(0);
                          });
                        }
                      : null,
                  child: Text(
                   'Save',
                    style: kTextStyle.copyWith(
                        color: getBtnColor(), fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            SizedBox(
              height: 60.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return ColorSelectorWidget(
                        clr: listOfColors[index],
                        index: index,
                        isSelected: Provider.of<NoteDatabaseProvider>(context)
                            .selectedIndex);
                  }),
            ),
            SizedBox(
              height: 15.h,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    autofocus: true,
                    controller: titleController,
                    onChanged: (v) {
                      getBtnColor();
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    style: kTextStyle.copyWith(
                        color: kWhiteColor,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                        hintText: 'Add your title',
                        hintStyle: kTextStyle.copyWith(
                            color: Colors.white54,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w400),
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    DateFormat.yMMMMd().format(
                      DateTime.now(),
                    ),
                    style: kTextStyle.copyWith(
                        color: const Color(0xff575296),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        TextField(
                          controller: descController,
                          onChanged: (v) {
                            getBtnColor();
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: kTextStyle.copyWith(
                              color: kWhiteColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.normal),
                          decoration: InputDecoration(
                              hintText: 'Write your description...',
                              hintStyle: kTextStyle.copyWith(
                                  color: Colors.white54,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal),
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              border: InputBorder.none),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
