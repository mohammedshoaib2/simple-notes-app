import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/models/note_data_provider.dart';
import 'package:simple_notes_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return ChangeNotifierProvider(
          create: (_) {
            return NoteDatabaseProvider();
          },
          child: MaterialApp(
            title: 'Simple Notes',
            theme: ThemeData(canvasColor: Colors.transparent),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}










/* The Purpose of Our Life is to be Happy */

