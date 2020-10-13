import 'package:flutter/cupertino.dart';
import 'package:mathe_app/index.dart';

class Profil extends StatefulWidget {
  Profil() : super();

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  
  BottomNaviBar bNaviBar;

  // boolean Variables for switching on and of
  bool foo;

  @override
  void initState() {
    bNaviBar = BottomNaviBar();
  }

  // Auslesen der fertig bearbeiteten Aufgaben im Quizteil
  Future<List<int>> _readQuizInfo() async {
    var prefs = await SharedPreferences.getInstance();
    int numGesamt = prefs.getInt("quiz" + "g");
    int numGeloest = prefs.getInt("quiz" + "r");
    return [numGeloest, numGesamt];
  }

  // Anzeige des Fortschritts im Quizteil (mit Text)
  Widget displayQuizInfo() {  
    return FutureBuilder(
      future: _readQuizInfo(),
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        List<int> l = snapshot.data ?? [];

        int numGeloest = l[0];
        int numGesamt = l[1];

        return Text(
          "Quizteil: $numGeloest von insgesamt $numGesamt Aufgaben gelöst",
          style: TextStyle(
            fontSize: 30,
            fontFamily: "SF Pro Custom"
          ),
        );
      }
    );
  }


  /// Widgets zum ZURÜCKSETZEN der App

  Widget resetButton() {
    return Container(
      child: RaisedButton(
        color: Colors.lightGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: Colors.transparent,
          )
        ),

        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        highlightElevation: 5,

        child: Text(
          "Reset",
          style: TextStyle(
            fontFamily: "SF Pro Custom",
            fontSize: 20
          ),
        ),

        onPressed: () {
          showCupertinoDialog(
            context: context, 
            builder: (BuildContext c) {
              return resetPopup();
            }
          );
        },
      )
    );
  }
    
  TextStyle popupButtonTextStyle = TextStyle(
    fontFamily: "SF Pro Custom",
    fontSize: 15
  );

  Widget resetPopup() {
    return CupertinoAlertDialog(
      title: Text(
        "Alle Zwischenstände im Quiz-Teil und alle Einstellungen werden zurückgesetzt!",
        style: TextStyle(
          fontFamily: "SF Pro Custom",
          fontSize: 15,
        )
      ),

      actions: [
        FlatButton(
          onPressed: (() => Navigator.pop(context)), 
          child: Text(
            "Abbruch",
            style: popupButtonTextStyle
          )
        ),

        FlatButton(
          onPressed: (() {
            _resetAll();
            Navigator.pop(context);
          }),
          child: Text(
            "Reset",
            style: popupButtonTextStyle,
          )
        )
      ],
    );
  }

  // Zurücksetzten der Einstellungen und des gesamten Fortschritts
  Future<void> _resetAll() async {
    // TODO
    var prefs = await SharedPreferences.getInstance();
    bool res = await prefs.clear();
    if (res) {
      // erfolgreiches Zurücksetzen
      showCupertinoDialog(context: context, builder: (BuildContext c) {
        return CupertinoAlertDialog(
          title: Text(
            "Alles erfolgreich zurückgesetzt!",
            style: TextStyle(
              fontFamily: "SF Pro Custom",
              fontSize: 20,
            ),
          ),
          
          actions: [
            FlatButton(
              child: Text(
                "Ok",
                style: popupButtonTextStyle
              ),
              onPressed: (() => Navigator.pop(c)),
            )
          ],
        );
      });
    }
  }

  

  Widget columnWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        displayQuizInfo(),
        resetButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: color_top_bar_app,
        title: Text(
          "Profil",
          style: top_bar_text_style,
          textAlign: TextAlign.center,
        ),

        // custom arrow back
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: () {
            // bNaviBar.pop();
            bNaviBar.goHome();
            // Navigator.of(context).pop();
          },
        ),   
      ),

      body: columnWidgets(),



      bottomNavigationBar: bNaviBar,
    );
  }
}