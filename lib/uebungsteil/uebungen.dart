import 'package:flutter/material.dart';

class Uebungen extends StatefulWidget {
  Uebungen({Key key}) : super(key: key);

  @override
  _UebungenState createState() => _UebungenState();
}

class _UebungenState extends State<Uebungen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Übungen"),));
  }
}
