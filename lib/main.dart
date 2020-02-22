import 'package:flutter/material.dart';
import 'package:mathe_app/bottom_navigation_bar.dart';
import 'package:mathe_app/buttons_homescreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mathe_app/home.dart';
import 'package:mathe_app/lernteil.dart';
import 'package:mathe_app/quiz/quiz.dart';
import 'package:mathe_app/uebungsteil/uebungen.dart';

import 'design_registry.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mathe App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          primaryColor: Colors.cyan[600],
          accentColor: Colors.lightGreen[500],
          textTheme: GoogleFonts.expletusSansTextTheme(
            Theme.of(context).textTheme,
          )),
      home: Home(),
      
    );
  }
}
