import 'package:flutter/material.dart';
import 'package:mathe_app/buttons_homescreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mathe_app/lernteil.dart';

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
        )
        


      ),
      home: MyHomePage(
        title: 'Mathe App',
        
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final button_lernteil = ButtonsHomescreen(
    "Lernteil",
    Farbe.lernteil,
    Colors.white,
    Colors.white,   
    Lernteil()
  );

  final button_uebungsteil = ButtonsHomescreen(
    "Übungsteil", 
    Farbe.uebungsteil_aufgaben, 
    Colors.white,
    Colors.white, 
    MyApp()
  );

  final button_quiz = ButtonsHomescreen(
    "Quiz", 
    Farbe.quiz_aufgaben, 
    Colors.white, 
    Colors.white,   
    MyApp()
  );

  final button_uebungsteil_loesungen = ButtonsHomescreen(
    "Lösungen", 
    Colors.white, 
    Farbe.uebungsteil_loesungen,
    Colors.black, 
    MyApp()
  );

  final button_quiz_loesungen = ButtonsHomescreen(
    "Lösungen",
    Colors.white, 
    Farbe.quiz_loesungen, 
    Colors.black,   
    MyApp()
  );

  static const double OFFSETLeft = 100;
  static const double OFFSETBetween = 20;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
                  
            // Lernteil
            // mit Padding, damit die Row nicht bis ganz nach rechts geht
            Padding(
              padding: EdgeInsets.only(left: OFFSETLeft, top: OFFSETLeft),
              child: button_lernteil.build(context),
            ),

            // Übungsteil
            Padding(
              padding: EdgeInsets.only(left: OFFSETLeft, top: OFFSETBetween),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // Button für Übungsteil
                  button_uebungsteil.build(context),
                  
                  // Button für Lösungen vom Übungsteil
                  button_uebungsteil_loesungen.build(context),
                                 

                  // Bild
                  //Image(image: AssetImage('graphics/mathe_bild.jpg'),)

              ],),
            ),

            // Quiz
            Padding(
              padding: EdgeInsets.only(left: OFFSETLeft, top: OFFSETBetween),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   
                  // Button für Quizze
                  button_quiz.build(context), 

                  // Button für Lösungen von den Quizzen 
                  button_quiz_loesungen.build(context),
                  
              ],)
            ),       

          ],
          
        ) 
    );
  }
}
