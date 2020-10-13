import 'package:flutter/cupertino.dart';
import 'package:mathe_app/index.dart';
import 'package:mathe_app/settings_no_state.dart';

class Quiz extends StatefulWidget {
  Quiz({this.childWidget}): super();
  final Widget childWidget;
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  BottomNaviBar bNaviBar;

  Widget childWidget;


  static const String mainPath = "assets/data/quiz/";

  @override
  void initState() {
    bNaviBar = new BottomNaviBar();

    if (widget.childWidget == null) {
      childWidget = ListeQuizinhalte1(
        topicsPath: "liste_quizinhalte.txt",
        mainPath: mainPath,
        schwierigkeitenPath: "schwierigkeitsstufen.txt",
      );
    } else childWidget = widget.childWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: color_top_bar_app,
        title: Text(
          "Quiz",
          style: top_bar_text_style,
          textAlign: TextAlign.center
        ),
        
        // custom arrow back
        leading: widget.childWidget is ListeQuizinhalte2 ? IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: () {
            print(widget.childWidget);
            // TODO fix bug
            if (widget.childWidget == null || widget.childWidget == ListeQuizinhalte2()) {
              try {bNaviBar.goHome();}
              on Error {
                print("catched");
                bNaviBar = BottomNaviBar();
                bNaviBar.goHome();
              }
            } else {
              Navigator.pop(context);
            }
            
            // Navigator.push(context, CustomTransition(page: HomeScreen()));
            // Navigator.of(context).pop();
          },
        ) : Container(),

        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _handleClick,
            itemBuilder: (BuildContext context) {
              return {"Reset"}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice, style: TextStyle(fontFamily: "SF Pro Custom"),)
                );
              }).toList();
            }
          )
        ],
      ),

      // TODO rewrite 'AnsichtLerninhalte()'
      body: childWidget,

      bottomNavigationBar: bNaviBar,
      backgroundColor: color_background,
    
    );
  }
  
  Future<void> _handleClick(String value) async {
    switch (value) {
      case "Reset":
      await showCupertinoDialog(
        context: context, 
        builder: (BuildContext c) {
          return SettingsNoState(context: context).resetPopup();
        }
      );         
    }

    // if (childWidget is ListeQuizinhalte1) {
    //     childWidget = new ListeQuizinhalte1(
    //       topicsPath: "liste_quizinhalte.txt",
    //       mainPath: mainPath,
    //       schwierigkeitenPath: "schwierigkeitsstufen.txt");
    //   }
    // setState(() {
    //   this.childWidget = childWidget;
    // });

    // Navigator.push(context, CustomTransition(page: HomeScreen()));

    // go to Homescreen
    var bN = BottomNaviBar();
    bN.goHome();
    
  }
}