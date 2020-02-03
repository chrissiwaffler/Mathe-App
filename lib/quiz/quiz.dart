import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  Quiz({Key key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Quiz"),));
  }
}