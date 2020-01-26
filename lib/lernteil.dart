import 'package:flutter/material.dart';

class Lernteil extends StatefulWidget {
  Lernteil({Key key}) : super(key: key);

  @override
  _LernteilState createState() => _LernteilState();
}

class _LernteilState extends State<Lernteil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lerninhalte"),
      ),
    );
  }
}