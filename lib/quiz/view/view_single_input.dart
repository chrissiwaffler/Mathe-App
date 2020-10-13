import 'package:mathe_app/index.dart';

class SingleInput extends QuizViewingTemplate {
  SingleInput({this.textPath}) : super();

  final String textPath;

  _SingleInputState _sis;

  @override
  _SingleInputState createState() => _sis = _SingleInputState();

  @override
  bool validateInput() {
    return _sis.validateInput();
  }
}

class _SingleInputState extends State<SingleInput> {
  String aufgabenText;

  // gegebener, richtiger Wert
  int rightInput;

  // aktuell eingegebener Wert über controller
  TextEditingController _controller = TextEditingController();

  int isRight = 0;
  
  @override
  void initState() {
    loadTextFile();
  }

  @override 
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> loadTextFile() async {
    List<String> list = await TxtFileLoader().loadSplittedLines(widget.textPath, true);

    int akt = 0;

    if (list[akt].contains("text")) {
      akt++;
      aufgabenText = list[akt];
      akt++;
    }

    if (list[akt].contains("e:")) {
      akt++;
    } else return;

    // Laden der richtigen Lösung
    int rightInput = int.parse(list[akt]);

    // State wird neu gesetzt
    setState(() {
      this.aufgabenText = aufgabenText;
      this.rightInput = rightInput;
    });

    // eventuell bestehenden Wert laden
    loadValue();

  }

  bool validateInput() {
    int currentInput = int.parse(_controller.text);
    bool returnValue = this.rightInput == currentInput;

    if (returnValue) {
      isRight = 1;
    } else {
      isRight = -1;
    }
    setState(() => this.isRight = isRight);

    // neuer Wert wird gespeichert
    saveValue();

    return returnValue;
  }
  
  Future<void> saveValue() async {
    var prefs = await SharedPreferences.getInstance();
    // aktuell eingegebener Wert wird gespeichert
    int currentInput = int.parse(_controller.text);
    await prefs.setInt(widget.textPath, currentInput);
    
    // aktuelle Farbe wird gespeichert
    await prefs.setInt(widget.textPath+"r", this.isRight);
  }

  Future<void> loadValue() async {
    var prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(widget.textPath);
    if (value != null) {
      setState(() {
        _controller.text = value.toString();
      });
    }
    
    // Farbe wird geladen
    int color = prefs.getInt(widget.textPath+"r");
    if (color == null) {
      isRight = 0;
    } else if (color > 0) {
      isRight = 1;
    } else {
      isRight = -1;
    }
    setState(() => this.isRight = isRight);

  }
  

  // Eingabefeld wird hiererstellt
  Widget buildInput() {
    return TextFormField(
      autocorrect: false,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      autofocus: false,
      // TODO style
      style: TextStyle(
        fontFamily: "SF Pro Custom",
        fontSize: 20
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly
      ],
      controller: _controller,
      enableSuggestions: false,
      keyboardType: TextInputType.number,

      decoration: InputDecoration(
        hintText: "?"
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    Color col;
    if (this.isRight == 0 || this.isRight == null) {
      col = Colors.transparent;
    } else if (this.isRight > 0) {
      // richtige Antwort
      col = Colors.greenAccent;
    } else {
      col = Colors.redAccent;
    }

    return Container(
      color: col,
      width: MediaQuery.of(context).size.height * 0.5,
      child: buildInput()
    );
  }
}