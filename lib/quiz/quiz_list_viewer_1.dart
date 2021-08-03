import 'package:mathe_app/index.dart';

class ListeQuizinhalte1 extends StatefulWidget {
  ListeQuizinhalte1({this.topicsPath, this.schwierigkeitenPath, this.mainPath}) : super();
  
  // Path of the txt-File with all the headings
  final String topicsPath, schwierigkeitenPath;

  // main path of the current directory, e.g. 'assets/data/lernteil/'
  final String mainPath;

  @override
  _ListeQuizinhalte1State createState() => _ListeQuizinhalte1State();
}

class _ListeQuizinhalte1State extends State<ListeQuizinhalte1> {  

  int numAufgaben;
  // Speichern wie viele Aufgaben gelöst wurden
  List<List<int>> infosAufgaben;

  Future<List<String>> _loadLerninhalteList() async {
    List<String> list = await TxtFileLoader().loadSplittedLines(widget.mainPath + widget.topicsPath, true);

    // String txt = await rootBundle.loadString(widget.mainPath + widget.topicsPath);
    // List<String> list = LineSplitter().convert(txt).toList();

    List<String> arr = new List(list.length);

    list.forEach((element) {
      List<String> l = element.split(":");
      if (l[0] != "") {
        int i = int.parse(l[0]);
        // arr[i] = l[1];
        
        
        // Der Titel kann nach der Nummer mit Doppelpunkt einen Titel mit Untertitel enthalten, 
        // die durch einen Doppelpunkt getrennt sind
        // daher werden die restliche Strings (falls mehrere vorhanden) die durch Doppelpunkte getrennt sind wieder zusammengefügt
        String newString = "";
        l.getRange(1, l.length).forEach((element) {
          newString += element;
        });

        // Nummerierung in der Text-Datei beginnt bei 1
        arr[i-1] = newString;
      }
    });
    

    // restliche null-Elemente entfernen
    for (int i = 0; i < arr.length; i++) {
      if (arr[i] == null) {
        arr = arr.sublist(0, i);
        break;
      }
    }

    return arr;
  }

  @override
  void initState() { 
    super.initState();
  }


  ListeQuizinhalte2 createChild(int number, String title) {
    // TODO fileName
    return ListeQuizinhalte2(
      number: number,
      title: title, 
      fileName: widget.schwierigkeitenPath, 
      mainPath: widget.mainPath
    );
    
  }

  // Methode zum Erzeugen des nachfolgenden Widgets,
  // Navigator wartet solange bis man zurück zur aktuellen Ansicht kommt,
  // dann wird die Fortschrittsanzeige aktualisiert
  Future<void> _cardOnTap(int number, String title) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Quiz(childWidget: createChild(number, title)))
    );

    // anschließendes Aktualisieren
    updateInfosAufgaben();
  }

  Widget makeCard(int number, String title) {
    return GestureDetector(
      onTap: () {
        // nachfolgendes Widget wird erstellt und geladen
        _cardOnTap(number, title);
        // Navigator.push(context, MaterialPageRoute(builder: (context) => Quiz(childWidget: createChild(number, title))));
      },
      child: ClipRRect(
      // Radius der Kante des Schatten
      borderRadius: BorderRadius.circular(10.0),
      child: Card(
        // Radius der Kante der Karte (der Farbe)
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          
          child: makeListTile(number, title)
        )))
    );
  }
  double left_padding_list_text = 20.0;
  

  Widget makeListTile(int number, String title) {
    String info = "";
    if (this.infosAufgaben[number] != null) {
      info = "${this.infosAufgaben[number][0]} von ${this.infosAufgaben[number][1]} gelöst";
    }
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),  
      
      // linker Container
      leading: ConstrainedBox(
        constraints: BoxConstraints(
          // maxWidth: MediaQuery.of(context).size.width * 0.0,
          maxWidth: MediaQuery.of(context).size.width * 0.04
        ),
        child: Container(
          
          // padding: EdgeInsets.only(right: 10.0),
          alignment: Alignment.center,
          decoration: new BoxDecoration(
            // border: new Border(
            //   right: new BorderSide(
            //     width: 2.0, color: Colors.greenAccent
            //   ),
            // )
          ),
          
          // Symbol links
          child: Icon(
            Icons.blur_on,
            color: color_list_arrow,
            size: 25,
          ),
        ),
      ),

      // Überschrift
      title: Container(
        padding: EdgeInsets.only(left: left_padding_list_text),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 2.0, color: color_left_border_list_text
            )
          )
        ),
        child: AutoSizeText(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontFamily: "SF Pro Custom",
            fontSize: 25,
            letterSpacing: 0.6
          ),
          maxLines: 2,
          maxFontSize: 25,
        ),
      ),

      // Leiste unter dem Titel
      subtitle: Container(
        padding: EdgeInsets.only(left: left_padding_list_text, top: 5),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 2.0, color: color_top_bar_app
            )
          )
        ),

        child: Row(
          children: <Widget>[
            Icon(
              Icons.linear_scale,
              color: color_list_arrow
            ),
            
            SizedBox(width: 10),

            // Untertitel
            AutoSizeText(
              info,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "SF Pro Rounded",
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              maxFontSize: 20,
            )
          ],
        ),
      ),

      // Symbol rechts
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: color_list_arrow,
        size: 60,
      )
    );
  }
  
  Future<void> updateInfosAufgaben() async {
    if (this.infosAufgaben == [] || this.infosAufgaben == null || this.infosAufgaben.length != this.numAufgaben) {
      this.infosAufgaben = List<List<int>>(this.numAufgaben);
    }
    
    int numGesamt;
    int numGeloest;

    var prefs = await SharedPreferences.getInstance();
    List<List<int>> arr = await Helper().loadSchwierigkeitenList(widget.mainPath + widget.schwierigkeitenPath);
    List<String> topicsList = await _loadLerninhalteList();
    for (int i = 0; i < this.numAufgaben; ++i) {
      String path = "${topicsList[i]}";

      // Kann nichts geladen werden --> Anzahl der Aufgaben wird selbst ermittelt
      // Alle Teilaufgaben müssen geladen
      // es wurden noch keine Aufgaben bearbeitet
      if (prefs.getInt(path+"r") == null) {
        numGeloest = 0;
        numGesamt = 0;

        // die Anzahl der Unteraufgaben einer Aufgabe eines Topics werden geladen 
        for (int j = 1; j <= arr[i].length; ++j) {
          String path = "${i+1}_$j.txt";
          String fullPath = "${widget.mainPath}$path";

          try {
            numGesamt += await Helper().getNumberTasks(fullPath);
          }
          catch (e) {
            print("$e \n Datei konnte nicht geladen werden:: $path");
          }
          
        }
        

        
        // try {
        //   int einzelneAufgaben = await
        // }
      } else {
        numGeloest = prefs.getInt(topicsList[i] + "r");
        numGesamt = prefs.getInt(topicsList[i] + "g");
      }

      setState(() {
        this.infosAufgaben[i] = [numGeloest, numGesamt];
      });

    }

      int sumNumGeloest = 0;
      int sumNumGesamt = 0;
      for (int i = 0; i < this.infosAufgaben.length; ++i) {
        sumNumGeloest += this.infosAufgaben[i][0];
        sumNumGesamt += this.infosAufgaben[i][1];
      }

      await prefs.setInt("quiz" + "g", sumNumGesamt);
      await prefs.setInt("quiz" + "r", sumNumGeloest);
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadLerninhalteList(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        
        if(snapshot.hasError) {
          // TODO return: show error widget
        }
        List<String> liste = snapshot.data ?? [];
        
        if (this.numAufgaben != liste.length) {
          this.numAufgaben = liste.length;
          updateInfosAufgaben();
        }

        return ListView.builder(
          itemCount: liste.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(index, '${liste[index]}');
          },
          padding: const EdgeInsets.all(8),
        );
      
    });
  }
}

