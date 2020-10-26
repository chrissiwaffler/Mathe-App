import 'package:mathe_app/index.dart';

class MultipleChoice extends QuizViewingTemplate {
  MultipleChoice({this.textPath}) : super();

  final String textPath;

  _MultipleChoiceState _mcs;


  @override
  _MultipleChoiceState createState() => _mcs =_MultipleChoiceState();

  @override
  bool validateInput() {
    return _mcs.validateInput();
  }
}

class _MultipleChoiceState extends State<MultipleChoice> {
  String aufgabenText;

  List<String> _auswahlMoeglichkeiten;
  int _indexRichtig;
  List<bool> _auswahlMoeglichkeitenSelected;
  List<int> _auswahlMoeglichkeitenFarbe;

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

    _auswahlMoeglichkeiten = List<String>(numMoeglichkeiten);
    for (int i = 0; i < numMoeglichkeiten; ++i) {
      _auswahlMoeglichkeiten[i] = list[akt + i];
    }
    akt += numMoeglichkeiten;

    if (list[akt].contains("r:")) {
      _indexRichtig = int.parse(list[akt + 1])-1;
    }

    _auswahlMoeglichkeitenSelected = List<bool>(numMoeglichkeiten);
    _auswahlMoeglichkeitenFarbe = List<int>(numMoeglichkeiten);

    // auswahlMoeglichkeitenSelected.forEach((element) {element=false;});

    
    // auswahlMoeglichkeitenFarbe.forEach((element) {element = 0;});

    for (int i = 0; i < numMoeglichkeiten; ++i) {
      _auswahlMoeglichkeitenSelected[i] = false;
      _auswahlMoeglichkeitenFarbe[i] = 0;
    }

    // State wird neu gesetzt
    setState(() {
      this.aufgabenText = aufgabenText;
      this._auswahlMoeglichkeiten = _auswahlMoeglichkeiten;
      this._indexRichtig = _indexRichtig;

      this._auswahlMoeglichkeitenSelected = _auswahlMoeglichkeitenSelected;
      this._auswahlMoeglichkeitenFarbe = _auswahlMoeglichkeitenFarbe;
    });

    // eventuell bestehende Werte laden
    loadValues();

  }


  bool validateInput() {
    bool returnValue = false;
    for (int i = 0; i < this._auswahlMoeglichkeitenSelected.length; i++) {
      if (this._auswahlMoeglichkeitenSelected[i] != null) {
        if (this._auswahlMoeglichkeitenSelected[i]) {
          if (i == this._indexRichtig) {
            // richtige Antwort ausgewählt
            setState(() => this._auswahlMoeglichkeitenFarbe[i] = 1);
            returnValue = true;
            break;
          } else {
            // falsche Antwort ausgewählt
            setState(() => this._auswahlMoeglichkeitenFarbe[i] = -1);
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
    for (int i = 0; i < this._auswahlMoeglichkeitenSelected.length; i++) {
      if (this._auswahlMoeglichkeitenSelected[i] != null) {
        if (this._auswahlMoeglichkeitenSelected[i]) {
          // ausgewählte Antwort wird gespeichert
          int isRight = this._auswahlMoeglichkeitenFarbe[i];

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
          this._auswahlMoeglichkeitenSelected[feld] = true;
          this._auswahlMoeglichkeitenFarbe[feld] = isRight;
        });
      }
    }
  }


  // Antwortmöglichkeiten werden hier erstellt
  List<Widget> buildAnswers() {
    int n = this._auswahlMoeglichkeiten.length;
    List<Widget> list = List<Widget>(n);

    for (int i = 0; i < n; ++i) {
      
      Widget listTile = ListTile(
        title: Text(
          this._auswahlMoeglichkeiten[i],
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
      if (_auswahlMoeglichkeitenSelected[i] != null) {
        color = _auswahlMoeglichkeitenSelected[i] ? Colors.blueAccent : Colors.grey[300];
      } else color = Colors.grey[300];

      // die Antwort wurde überprüft
      if (_auswahlMoeglichkeitenFarbe[i] != 0 && _auswahlMoeglichkeitenFarbe[i] != null) {
        // die Antwort ist nun entweder falsch oder richtig
        if (_auswahlMoeglichkeitenFarbe[i] < 0) {
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
    for (int i = 0; i < _auswahlMoeglichkeitenSelected.length; ++i) {
      if (i != numberField) {
        _auswahlMoeglichkeitenSelected[i] = false;
      } else _auswahlMoeglichkeitenSelected[i] = true;
    } 

    setState(() {
      this._auswahlMoeglichkeitenSelected = _auswahlMoeglichkeitenSelected;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: buildAnswers(),
    );
  }
}