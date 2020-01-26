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
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          textAlign: TextAlign.center,),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 100, left: 50),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
                  
            // Lernteil
            // mit Padding, damit die Row nicht bis ganz nach rechts geht
            Padding(
              padding: EdgeInsets.only(right: 400),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // Button für Lerninhalte
                  new ButtonsHomescreen(
                    "Lernteil",
                    Farbe.lernteil,
                    Colors.white,
                    Colors.white,   
                    Lernteil()
                  ).build(context),  
              ],),
            ),

            // Übungsteil
            Padding(
              padding: EdgeInsets.only(right: 600),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Button für Übungsteil
                  new ButtonsHomescreen(
                    "Übungsteil", 
                    Farbe.uebungsteil_aufgaben, 
                    Colors.white,
                    Colors.white, 
                    MyApp()
                  ).build(context),

                  // Button für Lösungen vom Übungsteil
                  new ButtonsHomescreen(
                    "Lösungen", 
                    Colors.white, 
                    Farbe.uebungsteil_loesungen,
                    Colors.black, 
                    MyApp()
                  ).build(context),

                  // Bild
                  //Image(image: AssetImage('graphics/mathe_bild.jpg'),)

              ],),
            ),

            // Quiz
            Padding(
              padding: EdgeInsets.only(right: 600),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Button für Quizze
                  new ButtonsHomescreen(
                    "Quiz", 
                    Farbe.quiz_aufgaben, 
                    Colors.white, 
                    Colors.white,   
                    MyApp()
                  ).build(context),  
                
                  // Button für Lösungen von den Quizzen
                  new ButtonsHomescreen(
                    "Lösungen",
                    Colors.white, 
                    Farbe.quiz_loesungen, 
                    Colors.black,   
                    MyApp()
                  ).build(context)

              ],)
            ),       

          ],
          
        ) 
  ,
      )
    );
  }
}
