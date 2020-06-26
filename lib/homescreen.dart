import 'package:flutter/material.dart';
import 'package:mathe_app/bottom_navigation_bar.dart';
import 'package:mathe_app/buttons_homescreen.dart';
import 'package:mathe_app/design_registry.dart';
import 'package:mathe_app/lernteil.dart';
import 'package:mathe_app/main.dart';
import 'package:mathe_app/profil.dart';
import 'package:mathe_app/quiz/quiz.dart';
import 'package:mathe_app/uebungsteil/uebungen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  final String title = "Mathe App";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final buttonLernteil = ButtonsHomescreen(
      "Lernteil", Farbe.lernteil, Colors.white, Colors.white, Lernteil()
      //PDFSite()
      );

  final buttonUebungsteil = ButtonsHomescreen(
    "Übungsteil",
    Farbe.uebungsteil_aufgaben,
    Colors.white,
    Colors.white,
    Uebungen(),
  );

  final buttonQuiz = ButtonsHomescreen(
      "Quiz", Farbe.quiz_aufgaben, Colors.white, Colors.white, Quiz());

  final buttonUebungsteilLoesungen = ButtonsHomescreen("Lösungen", Colors.white,
      Farbe.uebungsteil_loesungen, Colors.black, MyApp());

  final buttonQuizLoesungen = ButtonsHomescreen(
      "Lösungen", Colors.white, Farbe.quiz_loesungen, Colors.black, MyApp());

  static const double OFFSETLeft = 100;
  static const double OFFSETBetween = 20;

  isHorizontal() {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    return currentOrientation == Orientation.landscape ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    var listViewOrientation =
        isHorizontal() == true ? Axis.vertical : Axis.horizontal;
    print("Horizontal: " + isHorizontal().toString());

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.title,
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ),
        // so dass man kein ListView braucht und die Größe der Buttons an die Größe des Geräts angepasst werden
        // so kann die App aufm Tablet und aufm Handy angesehen werden
        body: ListView(scrollDirection: listViewOrientation, children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Lernteil
              // mit Padding, damit die Row nicht bis ganz nach rechts geht
              Padding(
                padding: EdgeInsets.only(left: OFFSETLeft, top: OFFSETLeft),
                child: buttonLernteil,
              ),

              // Übungsteil
              Padding(
                padding: EdgeInsets.only(left: OFFSETLeft, top: OFFSETBetween),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Button für Übungsteil
                    buttonUebungsteil,
                    // Button für Lösungen vom Übungsteil
                    buttonUebungsteilLoesungen,
                    // Bild
                    //Image(image: AssetImage('graphics/mathe_bild.jpg'),)
                  ],
                ),
              ),

              // Quiz
              Padding(
                  padding:
                      EdgeInsets.only(left: OFFSETLeft, top: OFFSETBetween),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Button für Quizze
                      buttonQuiz,
                      // Button für Lösungen von den Quizzen
                      buttonQuizLoesungen
                    ],
                  )),
            ],
          )
        ]));
  }
}
