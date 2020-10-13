import 'package:mathe_app/index.dart';

class MultipleChoice extends QuizViewingTemplate {
  MultipleChoice({this.textPath}) : super();

  final String textPath;

  static _MultipleChoiceState _mcs;


  @override
  _MultipleChoiceState createState() => _mcs =_MultipleChoiceState();

  @override
  bool validateInput() {
    return _mcs.validateInput();
  }
}

class _MultipleChoiceState extends State<MultipleChoice> {
  String aufgabenText;

  List<String> auswahlMoeglichkeiten;
  int indexRichtig;
  List<bool> auswahlMoeglichkeitenSelected;
  List<int> auswahlMoeglichkeitenFarbe;

  // converting the number 1 -> A, 2 -> B, etc.
  String getStringFromNumber(int number) {
    List<int> arr = new List<int>.generate(26, (index) => index+65);
    return String.fromCharCode(arr[number]);
  }
  
  @override
  void initState() {
    loadTextFile();
  }

  Future<void> loadTextFile() async {
    List<String> list = await TxtFileLoader().loadSplittedLines(widget.textPath, true);

    int akt = 0;

    if (list[akt].contains("text")) {
      akt++;
      aufgabenText = list[akt];
      akt++;
    }

    if (list[akt].contains("mc:")) {
      akt++;
    } else return;

    // Laden der Auswahlmöglichkeiten
    int numMoeglichkeiten = int.parse(list[akt]);
    akt++;

    auswahlMoeglichkeiten = List<String>(numMoeglichkeiten);
    for (int i = 0; i < numMoeglichkeiten; ++i) {
      auswahlMoeglichkeiten[i] = list[akt + i];
    }
    akt += numMoeglichkeiten;

    if (list[akt].contains("r:")) {
      indexRichtig = int.parse(list[akt + 1])-1;
    }

    auswahlMoeglichkeitenSelected = new List<bool>(numMoeglichkeiten);
    auswahlMoeglichkeitenSelected.forEach((element) {element=false;});
    
    auswahlMoeglichkeitenFarbe = new List<int>(numMoeglichkeiten);
    auswahlMoeglichkeitenFarbe.forEach((element) {element = 0;});

    // State wird neu gesetzt
    setState(() {
      this.aufgabenText = aufgabenText;
      this.auswahlMoeglichkeiten = auswahlMoeglichkeiten;
      this.indexRichtig = indexRichtig;

      this.auswahlMoeglichkeitenSelected = auswahlMoeglichkeitenSelected;
      this.auswahlMoeglichkeitenFarbe = auswahlMoeglichkeitenFarbe;
    });

    // eventuell bestehende Werte laden
    loadValues();

  }


  bool validateInput() {
    bool returnValue = false;
    for (int i = 0; i < this.auswahlMoeglichkeitenSelected.length; i++) {
      if (this.auswahlMoeglichkeitenSelected[i] != null) {
        if (this.auswahlMoeglichkeitenSelected[i]) {
          if (i == this.indexRichtig) {
            // richtige Antwort ausgewählt
            setState(() => this.auswahlMoeglichkeitenFarbe[i] = 1);
            returnValue = true;
            break;
          } else {
            // falsche Antwort ausgewählt
            setState(() => this.auswahlMoeglichkeitenFarbe[i] = -1);
            returnValue = false;
            break;
          }
        }
      }
    }

    // neuen Werte werden gespeichert
    saveValues();

    return returnValue;
  }

  Future<void> saveValues() async {
    var prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < this.auswahlMoeglichkeitenSelected.length; i++) {
      if (this.auswahlMoeglichkeitenSelected[i] != null) {
        if (this.auswahlMoeglichkeitenSelected[i]) {
          // ausgewählte Antwort wird gespeichert
          int isRight = this.auswahlMoeglichkeitenFarbe[i];

          // Werte werden gespeichert
          await prefs.setStringList(widget.textPath, [i.toString(), isRight.toString()]);
        }
      }      
    }
  }

  Future<void> loadValues() async {
    var prefs = await SharedPreferences.getInstance();
    List<String> l = prefs.getStringList(widget.textPath);

    if (l != null) {
      if (l[0] != null) {
        // ausgewähltes Feld und dazugehörige Zahl (-1 oder 1) werden ausgelesen
        int feld = int.parse(l[0]);
        int isRight = int.parse(l[1]);

        setState(() {
          this.auswahlMoeglichkeitenSelected[feld] = true;
          this.auswahlMoeglichkeitenFarbe[feld] = isRight;
        });
      }
    }
  }


  // Antwortmöglichkeiten werden hier erstellt
  List<Widget> buildAnswers() {
    int n = this.auswahlMoeglichkeiten.length;
    List<Widget> list = List<Widget>(n);

    for (int i = 0; i < n; ++i) {
      
      Widget listTile = ListTile(
        title: Text(
          this.auswahlMoeglichkeiten[i],
          style: TextStyle(
            fontFamily: "SF Pro Custom",
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),

        leading: Container(
          child: Text(
            getStringFromNumber(i),
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              fontFamily: "SF Pro Rounded"
            ),
          ),

          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color_top_bar_app
          ),
          padding: EdgeInsets.all(10),
        ),

      );

      Color color;
      if (auswahlMoeglichkeitenSelected[i] != null) {
        color = auswahlMoeglichkeitenSelected[i] ? Colors.blueAccent : Colors.grey[300];
      } else color = Colors.grey[300];

      // die Antwort wurde überprüft
      if (auswahlMoeglichkeitenFarbe[i] != 0 && auswahlMoeglichkeitenFarbe[i] != null) {
        // die Antwort ist nun entweder falsch oder richtig
        if (auswahlMoeglichkeitenFarbe[i] < 0) {
          // ausgewählte Antwort ist falsch
          color = Colors.redAccent;
        } else {
          // ausgewählte Antwort ist richtig
          color = Colors.greenAccent;
        }
      }
      
      Widget card = ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.antiAlias,
          elevation: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          color: Colors.transparent,
          child: Container(
            color: color,
            child: listTile
          )
        )
      );

      list[i]= GestureDetector(
        onTap: () {
          _onTapCard(i);
        },
        child: card
      );


    }

    return list;
  }

  

  _onTapCard(int numberField) {
    print("selected: $numberField");
    for (int i = 0; i < auswahlMoeglichkeitenSelected.length; ++i) {
      if (i != numberField) {
        auswahlMoeglichkeitenSelected[i] = false;
      } else auswahlMoeglichkeitenSelected[i] = true;
    } 

    setState(() {
      this.auswahlMoeglichkeitenSelected = auswahlMoeglichkeitenSelected;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: buildAnswers(),
    );
  }
}