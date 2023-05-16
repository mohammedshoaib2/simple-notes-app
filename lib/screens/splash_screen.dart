import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_notes_app/constants.dart';
import 'package:simple_notes_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void callHomeScreen() {
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (builder) {
          return const HomeScreen();
        }), (route) => false);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    callHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              'Simple Notes App',
              style: kTextStyle.copyWith(color: kWhiteColor, fontSize: 25.sp),
            ),
            const Spacer(),
            const CircularProgressIndicator(
              color: kWhiteColor,
              strokeWidth: 3,
            ),
            SizedBox(
              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }
}
