import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListeLerninhalte extends StatefulWidget {
  ListeLerninhalte({Key key}) : super(key: key);

  @override
  _ListeLerninhalteState createState() => _ListeLerninhalteState();
}

class _ListeLerninhalteState extends State<ListeLerninhalte> {
  
  
  
  Future<List<String>> loadLerninhalteList() async {
    String txt = await rootBundle.loadString('assets/Lerninhalte/liste_lerninhalte.txt');
    List <String> list = LineSplitter().convert(txt).toList();
    return list;
  }


  @override
  Widget build(BuildContext context) {
    
    Future<List> liste = loadLerninhalteList();
    //TODO: Future handler 
    //TODO: ich kotzee

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: //TODO: Liste hierrein!!!,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Center(child: Text('${liste[index]}')),
        );
      }
    );

       
    
  }
}