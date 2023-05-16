// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/constants.dart';
import 'package:simple_notes_app/models/note_data_provider.dart';
import 'package:simple_notes_app/screens/add_or_edit_screen.dart';
import 'package:simple_notes_app/widgets/custom_button.dart';
import 'package:simple_notes_app/widgets/note_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future refreshNotes() async {
    await Provider.of<NoteDatabaseProvider>(context, listen: false)
        .queryAllNote();
  }

  callRefreshInit() async {
    await Future.delayed(Duration.zero, () async {
      await refreshNotes();
    });
  }

  @override
  void initState() {
    super.initState();
    callRefreshInit();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Notes',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp),
                ),
                CustomButton(
                    icon: Icons.add,
                    onTap: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return AddOrEditScreen();
                      }));
                    }),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Provider.of<NoteDatabaseProvider>(context).mainList.isEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                      Center(
                        child: SvgPicture.asset(
                          'assets/no_data.svg',
                          height: 200.h,
                          width: 200.w,
                        ),
                      ),
                      Text(
                        'Nothing to show here!',
                        style: kTextStyle.copyWith(
                            color: kWhiteColor,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'You have\'nt created any notes,\nStart creating now.',
                        textAlign: TextAlign.center,
                        style: kTextStyle.copyWith(
                            color: kWhiteColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  )
                : Expanded(
                    child: MasonryGridView.count(
                        physics: BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        itemCount: Provider.of<NoteDatabaseProvider>(context)
                            .mainList
                            .length,
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 15.h,
                        itemBuilder: (context, index) {
                          final refNote =
                              Provider.of<NoteDatabaseProvider>(context)
                                  .mainList[index];
                          return NoteCard(
                            title: refNote.title,
                            description: refNote.description,
                            time: refNote.time,
                            color: refNote.color,
                            note: refNote,
                            index: index,
                          );
                        }))
          ]),
        ),
      ),
    );
  }
}
