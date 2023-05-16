import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/constants.dart';
import 'package:simple_notes_app/models/note_data_provider.dart';

class ColorSelectorWidget extends StatelessWidget {
  final Color clr;

  final int index;
  final int isSelected;

  const ColorSelectorWidget(
      {super.key,
      required this.clr,
      required this.index,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (index != isSelected) {
          Provider.of<NoteDatabaseProvider>(context, listen: false)
              .toggleSelect(index);
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        height: 60.h,
        width: 60.h,
        decoration:
            BoxDecoration(color: clr, borderRadius: BorderRadius.circular(5.r)),
        child: index == isSelected
            ? Icon(
                Icons.check,
                color: kWhiteColor,
                size: 35.h,
              )
            : const Text(''),
      ),
    );
  }
}
