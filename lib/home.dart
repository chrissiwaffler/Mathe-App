import 'package:flutter/material.dart';
import 'package:mathe_app/bottom_navigation_bar.dart';
import 'package:mathe_app/buttons_homescreen.dart';
import 'package:mathe_app/design_registry.dart';
import 'package:mathe_app/homescreen.dart';
import 'package:mathe_app/lernteil.dart';
import 'package:mathe_app/main.dart';
import 'package:mathe_app/profil.dart';
import 'package:mathe_app/quiz/quiz.dart';
import 'package:mathe_app/uebungsteil/uebungen.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  final String title = "Mathe App";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

  // für die Navigationsleiste unten
  int _selectedIndex = 0;

  final List<Widget> _tabs = [HomeScreen(), Lernteil(), Quiz(), Profil()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
        body: _tabs[_selectedIndex],

        // Navigationsleiste unten
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          //iconSize: 30,

          //backgroundColor: Colors.purple[400],
          selectedItemColor: Colors.lightBlue,
          //unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books), title: Text("Lernen")),
            BottomNavigationBarItem(
                icon: Icon(Icons.question_answer), title: Text("Quiz")),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text("Profil"),
                backgroundColor: Colors.blue)
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
