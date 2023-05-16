import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_notes_app/constants.dart';

class BottomBarButton extends StatelessWidget {
  final String tile;
  final VoidCallback onTap;

  const BottomBarButton({super.key, required this.tile, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 60.h,
          decoration: BoxDecoration(
              color: kWhiteColor, borderRadius: BorderRadius.circular(100.r)),
          child: Text(
            tile,
            style: kTextStyle.copyWith(
                color: kBackgroundColor, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
