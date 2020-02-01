import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class JsonLoader {
  final String jsonName;
  JsonBaum baum;

  JsonLoader(this.jsonName);
  
  Future<JsonBaum> makeJsonBaum() async {
    String data = await rootBundle.loadString("assets/data/"+jsonName);
    var json_file = jsonDecode(data);
    assert(json_file is List);

    // rekursiver Aufruf muss erfolgen
    // wenn data dann wieder json is 
    
    List data_list = json_file[0];
    for(int i; i<data_list.length/2; i++) {
      String name = data_list = 
    }
  }




}


class JsonBaum {
  final Knoten<String> wurzel;

  JsonBaum(this.wurzel);
  
  Knoten<String> getWurzel() {
    return wurzel;
  }

  addKnoten(Knoten<String> knoten) {

  }

}

class Knoten <String> {

  final String anzeigeName;
  final JsonEncoder child;
  List<Knoten<String>> children;

  Knoten(this.anzeigeName, this.child);

  String getAnzeigeName() {
    return anzeigeName;
  }

  List<Knoten<String>> getChildren() {
    return children;
  }


}