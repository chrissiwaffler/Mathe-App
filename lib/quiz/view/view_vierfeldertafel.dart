import 'package:mathe_app/index.dart';

class VierfelderTafel extends QuizViewingTemplate {
  VierfelderTafel({this.textPath, this.textStyleVariables, this.textStyleInhalt}) : super();
  final String textPath;
  final TextStyle textStyleVariables, textStyleInhalt;

  static _VierfelderTafelState _vft;

  String getDefinitionen() {
    return _vft.definitionen;
  }
  
  String getAufgabentext() {
    return _vft.aufgabenText;
  }

  @override
  _VierfelderTafelState createState()  =>  _vft = _VierfelderTafelState();

  bool validateInput() {
    return _vft.validateInput();
  }
}

class _VierfelderTafelState extends State<VierfelderTafel> {
  String aufgabenText;

  String definitionen = "";

  // Variable 1 und 2
  List<String> variables = (List<String>(2));
  List<dynamic> values = List<dynamic>();

  // Liste mit Indeces der freien Felder (Lücken)
  List<int> freieFelderIndeces = List<int>();
  List<TextEditingController> freieFelderTextController = List<TextEditingController>();
  List<int> freieFelderValidation = List<int>();
  int numFreieFelder = 0;

  static const EdgeInsets felderPadding = EdgeInsets.all(10);

  @override
  void initState() {
    loadTextFile();
  }

  Future<void> loadTextFile() async {
    List<String> list = await TxtFileLoader().loadSplittedLines(widget.textPath, true);
    int akt = 0;
    if (list[akt].contains("text")) {
      akt++;
      this.aufgabenText = list[akt];
      akt++;
    }
    if (list[akt].contains("vft:")) {
      akt++;
    } else return;

    // Variablen Definition
    if (list[akt].contains("v:")) {
      // 'v:' wird entfernt
      String def = list[akt].substring(3);

      List<String> arr = List<String>();
      // bei den Stellen des '='- und ';'-Zeichen wird getrennt
      List<String> l = def.split(" = ");
      l.forEach((element) {
        List<String> neue = element.split("; ");
        neue.forEach((e) { 
          if (e != null) arr.add(e);
        });
        // for (int i = 0; i < neue.length; ++i) {
        //   if (neue[i] != null) {
        //     arr.add(neue[i]);
        //   }
        // }
      });
      

      // Fügt Anführungszeichen und Doppelpunkte ein, damit z.B. ' M: "Mountainbike" ' erreicht wird
      for (int i = 0; i < arr.length; ++i) {
        if (i%2 == 0) {
          definitionen+=(arr[i]+": ");
          variables[i~/2] = arr[i];
        } else {
          definitionen += ('"' + arr[i] + '" ');
        }
      }
    }
    akt++;

    // Inhalt der Vierfeldertafel wird verarbeitet
    if (list[akt].contains("i:")) {
      akt++;

      for (int i = akt; i < akt+9; ++i) {
        values.add(list[i]);
      }
    }

    akt += 9;

    int numFreieFelder = 0;
    // die Lücken (freie Felder) werden ausgelesen und gespeichert
    if (list[akt].contains("f:")) {
      akt++;

      for (int i = akt; i < list.length; ++i) {
        freieFelderIndeces.add(int.parse(list[i]) -1);        
        numFreieFelder ++;
      }
      // Textcontroller mit eventuell bestehenden Texten wird geladen
      loadTextController();
    }
    

    // State wird neu gesetzt   
    setState(() {
      this.numFreieFelder = numFreieFelder;
      this.freieFelderValidation = List<int>(numFreieFelder);

      this.definitionen = definitionen;
      this.values = values;
      this.variables = variables;
      this.freieFelderIndeces = freieFelderIndeces;
    });

  }
  
  Widget buildField(int fieldNumber) {
    bool t = false;
    bool b = false;
    bool l = false;
    bool r = false;

    if ((fieldNumber+1)%3 != 0 ) {
      r = true;
    }
    
    if (!freieFelderIndeces.contains(fieldNumber)) {

      
      return Container(
        padding: felderPadding,
        alignment: Alignment.center,
        // decoration: getBorderLine(r: r, l: l, b: b, t: t),
        child: Text(
          values[fieldNumber],
          style: widget.textStyleInhalt,
          textAlign: TextAlign.center,
            
        ),
      );

    } else {
      int numFreiesFeld = this.freieFelderIndeces.indexOf(fieldNumber);
      int validationValue = this.freieFelderValidation[numFreiesFeld];
      Color color;
      if (validationValue != null) {
        if (validationValue > 0) {
          color = Colors.greenAccent;
        } else if (validationValue < 0) {
          color = Colors.redAccent;
        }
      }

      Widget inputField = TextFormField(
        autocorrect: false,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        autofocus: false,
        expands: false,
        style: widget.textStyleInhalt,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ],
        controller: this.freieFelderTextController[numFreiesFeld],
        // maxLength: 5,
        // maxLengthEnforced: false,
        enableSuggestions: false,
        keyboardType: TextInputType.number,

        decoration: InputDecoration(
          hintText: "?",
        ),
      );
      

      return Container(
        padding: felderPadding,
        // decoration: getBorderLine(r: r, l: l, b: b, t: t, color: color),
        child: inputField,
      );
    }
  }

  Widget buildHeading(int variableNumber, bool nicht) {
    // es wird überprüft, ob an den Rändern des jeweiligen Felds ein schwarzer Rand sein soll
    bool t = false;
    bool b = false;
    bool r = true;
    bool l = false;

    // if (variableNumber == 0 && !nicht) {
    //   l = true;
    // }


    
    return Container(
      padding: felderPadding,
      // decoration: getBorderLine(r: r, l: l, t: t, b: b),
      child: Center(
        child: Text(
          nicht ? "'Nicht'-" + variables[variableNumber] : variables[variableNumber],
          style: widget.textStyleVariables
        ),
      ),
    );
  }

  BoxDecoration getBorderLine({bool t=false, bool r=false, bool l=false, bool b=false, Color color}) {
    var borderS  = BorderSide(color: Colors.black, width: 1.0);
    return BoxDecoration(
      color: color,
      border: Border(
        top: t ? borderS : BorderSide.none,
        right: r ? borderS : BorderSide.none,
        left: l ? borderS : BorderSide.none,
        bottom: b ? borderS : BorderSide.none
      )
    );
  }

  

  bool validateInput() {
    List<bool> arr = List<bool>(freieFelderIndeces.length);
    for (int i = 0; i < freieFelderIndeces.length; ++i) {
      // Wert, der zum Array 'freieFelderValidation' hinzugefügt wird
      int newValue = 0;

      int index = freieFelderIndeces[i];
      
      String rawInput = freieFelderTextController[i].text;
      if (rawInput != "") {

        int userInput = int.parse(freieFelderTextController[i].text);

        // boolscher Wert, wird zur Liste hinzugefügt
        // dieser beschreibt, ob der eingegebene Wert mit dem gewünschten Wert übereinstimmt
        bool e = userInput.toString() == values[index];
        arr[i] = e;
      

        if (e) {
          newValue = 1;
        } else {
          newValue = -1;
        }
      }
      setState(() {
        this.freieFelderValidation[i] = newValue;
      });
    }

    // Speichern der Eingabewerte
    setNewValues();

    bool isNull = false;
    for (int i = 0; i < arr.length; ++i) {
      if (arr[i] != null) {
        if (!arr[i]) {
          return false;
        }
      } else {
        isNull = true;
      }
    }
    if (isNull) return null;
    return true;
  }

  // Speichern der neuen Werte
  Future<void> setNewValues() async {
    var prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < this.numFreieFelder; ++i) {
      // Speichern des eingegebenen Textes
      await prefs.setString(widget.textPath+i.toString()+"c", this.freieFelderTextController[i].text);
    }
  }

  Future<void> loadTextController() async {
    var prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < this.numFreieFelder; ++i) {
      String text = prefs.getString(widget.textPath+i.toString()+"c".toString());
      TextEditingController controller = TextEditingController(text: text);
      
      setState(() {
        this.freieFelderTextController.add(controller);
      });
    }
    validateInput();
  }
  


  // TODO Delete unused Text
  // Widget getHeading() {
  //   return Text(
  //     "Bedeutung der Variablen:",
  //     style: TextStyle(
  //       fontFamily: "SF Pro Custom",
  //       fontSize: 20
  //     ),
  //   );
  // }

  // Widget getDefintions() {
  //   Text(
  //     definitionen,
  //     style: TextStyle(
  //       fontSize: 20,
  //       fontFamily: "SF Pro Custom"
  //     )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    BorderSide bs = BorderSide(
      color: Colors.black,
      width: 1.0
    );
     // Vierfeldertafel
    return Column(
      children: [
        Text(
          this.definitionen,
          style: widget.textStyleVariables
        ),
        SizedBox(height: 20),
        
        Container(
          width: MediaQuery.of(context).size.width*0.4,
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
            border: TableBorder.lerp(TableBorder(horizontalInside: bs, verticalInside: bs), TableBorder(), 0),
            children: [
              // 4 TableRows:

              // 1.
              TableRow(
                // decoration: getBorderLine(b: true),
                children: [
                Container(child: Text("")),
                buildHeading(0, false),
                buildHeading(0, true),
                Text("")
              ]),

              // 2.
              TableRow(
                // decoration: getBorderLine(b: true),
                children: [
                buildHeading(1, false),
                buildField(0),
                buildField(1),
                buildField(2)
              ]),

              // 3.
              TableRow(
                // decoration: getBorderLine(b: true),
                children: [
                buildHeading(1, true),
                buildField(3),
                buildField(4),
                buildField(5)
              ]),

              // 4. 
              TableRow(children: [
                Container(child: Text("")),
                buildField(6),
                buildField(7),
                buildField(8)
              ])
            ],
          ),
      ),]
    );
  }

}