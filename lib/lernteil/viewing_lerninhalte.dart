import 'package:flutter/material.dart';

class AnsichtLerninhalt extends StatefulWidget {
  AnsichtLerninhalt({Key key}) : super(key: key);

  @override
  _AnsichtLerninhaltState createState() => _AnsichtLerninhaltState();
}

class _AnsichtLerninhaltState extends State<AnsichtLerninhalt> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
        appBar: AppBar(title: Text("Ansicht"),),
        body: Image(image: AssetImage('assets/Lerninhalte/Bilder/Unbenannt.png')))
    );
  }
}