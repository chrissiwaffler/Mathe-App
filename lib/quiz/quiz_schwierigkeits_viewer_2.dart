import 'package:mathe_app/index.dart';
import 'package:mathe_app/quiz/view/quiz_master.dart';

class ListeQuizinhalte2 extends StatefulWidget {
  ListeQuizinhalte2({this.number, this.title, this.fileName, this.mainPath}) : super();

  final int number;
  final String title;
  final String fileName, mainPath;

  @override
  ListeQuizinhalte2State createState() => ListeQuizinhalte2State();
}

class ListeQuizinhalte2State extends State<ListeQuizinhalte2> {
  
  int numAufgaben;

  // Speichern, wie viele Aufgaben gelöst wurden
  List<List<int>> infosAufgaben;

  @override
  void initState() { 
    super.initState();
  }


  QuizMaster createChild(int schwierigkeitsgrad, int nummerAufgabe) {
    // TODO umändern
    // hier könnte die überprüfung stattfinden, die checkt, 
    // ob in der angeklickten Quizaufgabe Multiplechoice oder Input-Eingabe benötigt wird
    // child = QuizViewingMultiple();
    String path = "${widget.number+1}_${nummerAufgabe+1}.txt";
    return new QuizMaster(
      mainPath: widget.mainPath,
      textPath: path,
      schwierigkeitsstufe: schwierigkeitsgrad, 
      nummer: nummerAufgabe,
      topic: widget.title
    );
  }

  // Methode zum Erzeugen des nachfolgenden Widgets,
  // Navigator wartet solange bis man zurück zur aktuellen Ansicht kommt,
  // dann wird die Fortschrittsanzeige aktualisiert
  Future<void> _cardOnTap(int schwierigkeitsgrad, int nummerAufgabe) async {
    await Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => createChild(schwierigkeitsgrad, nummerAufgabe)));
    
    // anschließendes Aktualisieren
    updateInfosAufgaben();
    
  }

  Widget makeCard(int schwierigkeitsgrad, int nummerAufgabe) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => createChild(schwierigkeitsgrad, nummerAufgabe)));},
        _cardOnTap(schwierigkeitsgrad, nummerAufgabe);},
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
            // color: getColor(schwierigkeitsgrad)
            color: Colors.white
          ),
          
          child: makeListTile(schwierigkeitsgrad, nummerAufgabe)
        )))
    );
  }

  Color getColor(int schwierigkeitsstufe) {
    if (schwierigkeitsstufe == 1) {
      return Colors.green;
    } else if (schwierigkeitsstufe == 2) {
      return Colors.yellow;
    } else if (schwierigkeitsstufe == 3) {
      return Colors.red;
    } else {
      return Colors.white;
    }
  }

  double leftPaddingListText = 20.0;

  Widget makeListTile(int schwierigkeitsgrad, int nummerAufgabe) {
    String info = "";
    if (this.infosAufgaben[nummerAufgabe] != null) {
      info = "${this.infosAufgaben[nummerAufgabe][0]} von ${this.infosAufgaben[nummerAufgabe][1]} gelöst";
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
          alignment: Alignment.center,
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
        padding: EdgeInsets.only(left: leftPaddingListText),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 2.0, color: color_left_border_list_text
            )
          )
        ),
        child: AutoSizeText(
          "Nr. ${nummerAufgabe+1} (Schwierigkeitsgrad: $schwierigkeitsgrad)",
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
        padding: EdgeInsets.only(left: leftPaddingListText, top: 5),
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
    // Laden der Werte; Anzahl der richtigen und gesamten Aufgaben
    int numGesamt;
    int numGeloest;

    var prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < this.numAufgaben; ++i) {
      String path = "${widget.number+1}_${i+1}.txt";
      String fullPath = "${widget.mainPath}$path";

      // kann nichts geladen werden --> Anzahl der Aufgaben wird selbst ermittelt
      if(prefs.getInt(path+"r") == null) {
        numGesamt = 0;
        numGeloest = 0;

        try {
          numGesamt = await Helper().getNumberTasks(fullPath);
        }
        catch (e) {
          print("Datei konnte nicht gefunden werden: $path");
        }


      } else {
        numGeloest = prefs.getInt(path+"r");
        numGesamt = prefs.getInt(path+"g");
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
    // eigenen Wert speichern (... von .. gelöst)
    await prefs.setInt(widget.title + "r", sumNumGeloest);
    await prefs.setInt(widget.title + "g", sumNumGesamt);
  }

  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Helper().loadSchwierigkeitenList(widget.mainPath + widget.fileName),
      builder: (context, AsyncSnapshot<List<List<int>>> snapshot) {
        
        if(snapshot.hasError) {
          // TODO return: show error widget
        }
        List<int> liste = snapshot.data[widget.number] ?? [];

        if (this.numAufgaben != liste.length) {
          this.numAufgaben = liste.length;
          updateInfosAufgaben();
        }
        

        return ListView.builder(
          itemCount: liste.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(liste[index], index);
          },
          padding: const EdgeInsets.all(8),
        );
      
    });
  }
}