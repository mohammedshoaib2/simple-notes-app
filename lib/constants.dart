import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kBackgroundColor = Color(0xff1A183F);
const kButtonBackgroundColor = Color(0xff28264E);
const kTaskColor1 = Color(0xffFAB1A0);
const kTaskColor2 = Color(0xffFFEAA9);
const kTaskColor3 = Color(0xffA29AFD);
const kTaskColor4 = Color(0xFFfaedcd);
const kTaskColor5 = Color(0xff00B795);
const kTaskColor6 = Color(0xff74B9FF);
const kTaskColor7 = Color(0xffecf8f8);
const kTextColor1 = Color(0xff1C1C17);
const kWhiteColor = Color(0xFFFFFFFF);

TextStyle kTextStyle = TextStyle(
  color: kTextColor1,
  fontFamily: 'Poppins',
  fontSize: 18.sp,
  fontWeight: FontWeight.w700,
);

List<Color> listOfColors = [
  kTaskColor1,
  kTaskColor2,
  kTaskColor3,
  kTaskColor4,
  kTaskColor5,
  kTaskColor6,
  kTaskColor7,
];

int getIndexNumberOfColor(Color clr) {
  for (int index = 0; index < listOfColors.length; index++) {
    if (clr == listOfColors[index]) {
      return index;
    }
  }
  return 0;
}
