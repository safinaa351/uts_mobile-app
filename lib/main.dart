import 'package:flutter/material.dart';
import 'package:jurusan_inggris/pages/dashboard.dart';
import 'package:jurusan_inggris/pages/kalender.dart';
import 'package:jurusan_inggris/widgets/bottom_navbar.dart';
import 'package:jurusan_inggris/widgets/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Sarabun',
        primarySwatch: Colors.deepOrange,
      ),
      home: const MainPage(),
    );
  }
}
