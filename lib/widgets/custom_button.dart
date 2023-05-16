import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_notes_app/constants.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CustomButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: kButtonBackgroundColor,
            borderRadius: BorderRadius.circular(8.r)),
        child: Icon(
          icon,
          color: kWhiteColor,
          size: 30,
        ),
      ),
    );
  }
}
