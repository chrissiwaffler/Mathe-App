import 'package:flutter/cupertino.dart';
import 'package:mathe_app/index.dart';
import 'package:mathe_app/quiz/view/view_single_input.dart';

// ignore: must_be_immutable
class QuizMaster extends StatefulWidget {
  QuizMaster({this.mainPath, this.textPath, this.schwierigkeitsstufe, this.nummer, this.topic}) : super();
  final String mainPath, textPath, topic;
  final int schwierigkeitsstufe, nummer;

  _QuizMasterState qms;

  @override
  _QuizMasterState createState() => qms = _QuizMasterState();

  Future<void> updateValidationScoreAll() async {
    await qms.updateValidationScoreAll();
  }
}

class _QuizMasterState extends State<QuizMaster> {
  String aufgabeText;
  List<String> aufgabenNummern = List();

  List<Widget> widgets = List();

  List<QuizViewingTemplate> aufgabenBestandteile = List();

  List<bool> listValidation = List<bool>();

  // Zu Beginn werden die Anfangswerte genau einmal aktualisiert
  bool isAktualisiert;

  // VierfelderTafel vft;

  // TODO Textstyle für VFT
  TextStyle txtStyleVariables = TextStyle(
    fontFamily: "SF Pro Custom",
    fontSize: 20,
    fontWeight: FontWeight.bold
  );

  // TODO
  TextStyle txtStyleInhalt = TextStyle(
    fontFamily: "SF Pro Custom",
    fontSize: 18
  );

  Widget topic() {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
        child: FittedBox(
          child: Text(
            widget.topic,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "SF Pro Custom",
              fontSize: 40,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
    );
  }

  Widget informationHeading() {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
        child: FittedBox(
          child: Text(
            "Nummer: ${widget.nummer+1} (Schwierigkeitsgrad: ${widget.schwierigkeitsstufe})",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "SF Pro Custom",
              fontSize: 25,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
    );
  }

  Widget textAufgabenStellung() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: FittedBox(
          child: Text(
            "Aufgabenstellung:",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "SF Pro Custom",
              fontSize: 25,
              fontWeight: FontWeight.w600
            ),
          ),
        ),
    );
  }
  

  @override
  void initState() { 
    isAktualisiert = false;
    super.initState();
    _loadBasicText();
    this.widgets.add(topic());
    this.widgets.add(informationHeading());
  }

  Widget buildAufgabenText(List<String> listTexts) {
    // Erstellen eines Widgets für jeden Text String in 'list_texts'
    List<Widget> listTextWidgets = List();

    // Der Text "Aufgabenstellung" wird zu Beginn hinzugefügt
    listTextWidgets.add(textAufgabenStellung());

    // alle Zeilen der Aufgabenstellung werden hinzugefügt
    listTexts.forEach((text) {
      listTextWidgets.add(Text(
        text,
        softWrap: true,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: "SF Pro Custom",
          fontSize: 20
        )
      ));
    });
    
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 20.0),
      padding: EdgeInsets.all(20.0),

      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [BoxShadow(
            color: color_shadow,
            blurRadius: 20.0,
            offset: Offset(10, 10)
          )]
        ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: listTextWidgets,
      )

    );
  }

  Widget teilaufgabeHeading(int nummer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: FittedBox(
        child: Text(
          "Teilaufgabe ${nummer+1}:",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "SF Pro Custom",
            fontSize: 25,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
  
  Widget teilaufgabeText(String text) {
    return Text(
      text, 
      style: TextStyle(
        fontFamily: "SF Pro Custom",
        fontSize: 20
      ),
    );
  }

  // ladet den Text nach einem bestimmten Keywort bis eine leere Zeile kommt
  Future<List<String>> loadTextAfterKeyword(String path, String keyword) async {
    List<String> l = await TxtFileLoader().loadSplittedLines(path, false);
    List<String> list = List();
    for (int i = 0; i < l.length; ++i) {
      if (l[i].contains(keyword)) {
        // Aufgabentext wird ausgelesen und als Widget erstellt
        for (int j = i+1; j < l.length; j++) {
          // falls das Ende des Textes erreicht ist
          if (l[j] == "") break;
          list.add(l[j]);
        }
      }
    }
    return list;
  }

  Future<void> _loadBasicText() async {
      // fügt alle Textzeilen als Widget hinzu, die zur Aufgabenstellung gehören
      List<String> listAufgabenText = await loadTextAfterKeyword(widget.mainPath+widget.textPath, "text");

      setState(() => this.widgets.add(buildAufgabenText(listAufgabenText)));

      // ladet alle Nummern der Teilaufgaben, die angegeben sind (nach dem Wort)
      List<String> listTeilaufgabenNummern = await loadTextAfterKeyword(widget.mainPath+widget.textPath, "task");
      setState(() {
        this.aufgabenNummern = listTeilaufgabenNummern;
      });
  
    await _loadTeilaufgaben();
  }

  Future<void> _loadTeilaufgaben() async {
    String pathPrefix = widget.textPath.replaceAll(".txt", "");

    int numberAufgabe = 0;
    // wird für jede Teilaufgabe ausgeführt: 
    this.aufgabenNummern.forEach((aufgabenNummer) async {
      String path = widget.mainPath + pathPrefix + "_" + aufgabenNummer;
      String t = await TxtFileLoader().loadBasic(path);
      
      // Laden der Aufgabenstellung der Teilaufgabe
      List<String> l = await loadTextAfterKeyword(path, "text");

      List<Widget> teilaufgabeWidgets = List();
      // Hinzufügen der Teilaufgabennummer als Widget 
      teilaufgabeWidgets.add(teilaufgabeHeading(aufgabenNummern.indexOf(aufgabenNummer)));

      // fügt den Text der Teilaufgabe als Widgets hinzu
      l.forEach((element) {teilaufgabeWidgets.add(teilaufgabeText(element));});

      // Abstand nach unten 
      teilaufgabeWidgets.add(SizedBox(height: 15.0));

      // in das ListTile kommen alle benötigten Elemente
      ListTile listTile;

      // Vierfeldertafel wird benötigt
      if (t.contains("vft:")) {

        // Quizaufgabe mit Vierfeldertafel -> Vierfeldertafel wird geladen
        VierfelderTafel vft = new VierfelderTafel(
          textPath: path,
          textStyleInhalt: txtStyleInhalt,
          textStyleVariables: txtStyleVariables,
        );
        
        teilaufgabeWidgets.add(vft);
        aufgabenBestandteile.add(vft);

        Widget buttonValidate = validateButton(updateValidationScore, this.aufgabenBestandteile.indexOf(vft), "Speichern & Überprüfen");

        teilaufgabeWidgets.add(SizedBox(height: 15));
        teilaufgabeWidgets.add(buttonValidate);

        listTile = ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: teilaufgabeWidgets,
          ),

          trailing: informationButton("vft"),
        );

        numberAufgabe++;
      }

      // Multiple-Choice wird benötigt
      if (t.contains("mc:")) {
        MultipleChoice mc = new MultipleChoice(
          textPath: path,
        );
        teilaufgabeWidgets.add(mc);
        aufgabenBestandteile.add(mc);

        Widget buttonValidate = validateButton(updateValidationScore, this.aufgabenBestandteile.indexOf(mc), "Überprüfen");

        teilaufgabeWidgets.add(SizedBox(height: 15));
        teilaufgabeWidgets.add(buttonValidate);

        listTile = ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: teilaufgabeWidgets,
          )
        );

        numberAufgabe ++;
      }

      // Eingabefeld wird benötigt
      if (t.contains("e:")) {
        SingleInput e = new SingleInput(
          textPath: path
        );
        teilaufgabeWidgets.add(e);
        aufgabenBestandteile.add(e);

        Widget buttonValidate = validateButton(updateValidationScore, this.aufgabenBestandteile.indexOf(e), "Überprüfen");

        teilaufgabeWidgets.add(SizedBox(height: 15,));
        teilaufgabeWidgets.add(buttonValidate);

        listTile = ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: teilaufgabeWidgets,
          )
        );

        numberAufgabe ++;
      }

      Widget container = Container(
        alignment: Alignment.centerLeft,
        // margin: EdgeInsets.only(top: 10.0), // Margin wird bei dem oberen Widget hinzugefügt
        padding: EdgeInsets.all(20.0),

        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
            boxShadow: [BoxShadow(
              color: color_shadow,
              blurRadius: 20.0,
              offset: Offset(10, 10)
            )]
          ),

        child: listTile

      );

      setState(() {
        this.widgets.add(container);
        this.widgets.add(SizedBox(height: 30));
      });
    });
  }
  
  // Erstellen eines Buttons, der die gegebene Funktion mit dem gegebenen Wert aufruft
  Widget validateButton(Function function, dynamic value, String text) {
    return Container(
      child: RaisedButton(
        color: color_top_bar_app,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: Colors.transparent,
          )
        ),

        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        highlightElevation: 5,

        child: Text(
          text,
          style: TextStyle(
            fontFamily: "SF Pro Custom",
            fontSize: 20
          ),
        ),

        onPressed: () {
          function(value);
        },
      )
    );
  }

  // Aktualisieren der Werte, die angeben, ob die jeweilige Teilaufgabe gelöst wurde
  Future<void> updateValidationScore(int numTeilaufgabe) async {
    List<bool> listValidation = this.listValidation;
    int numAufgaben = this.aufgabenBestandteile.length;

    if (listValidation.length != numAufgaben) {
      listValidation = new List.filled(numAufgaben, false);
    }

    bool b = this.aufgabenBestandteile[numTeilaufgabe].validateInput();
    listValidation[numTeilaufgabe] = b;

    setState(() {
      this.listValidation = listValidation;
    });

    await updateSavings();
  }

  Future<void> updateSavings() async {
    int numGeloest = 0;
    int numAufgaben = this.aufgabenBestandteile.length;

    for (int i = 0; i < numAufgaben; ++i) {
      if (this.listValidation[i]) numGeloest++;
    }

    var prefs = await SharedPreferences.getInstance();

    // TODO check ob speicherort stimmt
    // Speichern der Anzahl der richtigen Aufgaben
    await prefs.setInt(widget.textPath + "r", numGeloest);

    // Speichern der Anzahl der gesamten Eingabemöglichkeiten
    await prefs.setInt(widget.textPath + "g", numAufgaben);
  }

  Future<void> updateValidationScoreAll() async {
    isAktualisiert = true;
    for (int i = 0; i < this.aufgabenBestandteile.length; i++) {
      await updateValidationScore(i);
    }
  }

  // 'i'-Button, der das Informations-Popup anzeigen lässt
  Widget informationButton(String fieldType) {
    return IconButton(
      iconSize: 30,
      icon: Icon(Icons.info_outline),
      color: Colors.blue,
      onPressed: () {

        // Falls das aktuelle Popup Informationen für die Vierfeldertafel anzeigen sollte
        if (fieldType == "vft") vftInformation();
        showCupertinoDialog(context: context, 
          builder: (BuildContext c) {
            return vftInformation();
          }
        );
        // TODO
        print("info-button");
        
      },
    );
  }

  static const TextStyle txtStyleInfoPopupTitle = TextStyle(
    fontFamily: "SF Pro Custom",
    fontSize: 25
  );
  static const TextStyle txtStyleInfoPopupContent = TextStyle(
    fontFamily: "SF Pro Custom",
    fontSize: 18
  );
  
  // Vorlage für das Popup;
  // beinhaltet die Actions die mit dem Popup 'gemacht' werden können
  List<Widget> getActionsInfoPopup(BuildContext c) {
    return [
        FlatButton(
          child: Text("Schließen",
            style: TextStyle(
              fontFamily: "SF Pro Custom",
              fontSize: 15
            )
          ),
          onPressed: (() => Navigator.pop(c)),
          // onPressed: () {
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListeQuizinhalte2()));
          // },
        )
      ];
  }
  
  // Popup für die Vierfeldertafel
  Widget vftInformation() {
    return CupertinoAlertDialog(
      title: Text("Info", style: txtStyleInfoPopupTitle),
      content: Text(
        "Auf die leeren Felder der Vierfeldertafel tippen und das Ergebnis eintragen.",
        style: txtStyleInfoPopupContent,
      ),
      actions: getActionsInfoPopup(context),
    );  
  }
  

  
  @override
  Widget build(BuildContext context) {
    if (!isAktualisiert) {
      // Zu Beginn werden alle bestehende Eingaben geladen und ausgewertet
      updateValidationScoreAll();
    }
    // TODO
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz",
          style: top_bar_text_style,
        ),
        backgroundColor: color_top_bar_app,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: this.widgets,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
      ),

      backgroundColor: color_background,
    );
  }
}