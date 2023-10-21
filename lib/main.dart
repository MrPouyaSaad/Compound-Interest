import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sood_morakb/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sood Morakab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.pink.shade400,
            onPrimary: Colors.white,
            secondary: Colors.white70,
            onSecondary: Colors.white70,
            error: Colors.redAccent.shade400,
            onError: Colors.white,
            background: Color.fromARGB(255, 30, 30, 30),
            onBackground: Colors.white,
            surface: Color(0x0dffffff),
            onSurface: Colors.white),
        appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            fontSize: 14,
          ),
          labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Color.fromARGB(9, 255, 255, 255),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
