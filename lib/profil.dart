import 'package:flutter/material.dart';

class Profil extends StatefulWidget {
  Profil({Key key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
      "Profil",
      style: TextStyle(fontSize: 30),
    ));
  }
}
