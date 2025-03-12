library;

import 'package:flutter/material.dart';
import 'moodtracker.dart';
import 'package:google_fonts/google_fonts.dart' as gf;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal[700],
        scaffoldBackgroundColor: Color(0xFFDFF5E1),
        textTheme: gf.GoogleFonts.juaTextTheme(), // Imported font
        appBarTheme: AppBarTheme(
          color: Colors.teal[700],
          titleTextStyle: gf.GoogleFonts.jua(
            textStyle: const TextStyle(
              color: Colors.white, 
              fontSize: 24, 
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 25, 97, 46)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFDFF5E1)),
          ),
        ),
      ),
      home: const MoodTrackerForm(),
    );
  }
}