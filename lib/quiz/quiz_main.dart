import 'package:mathe_app/index.dart';

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
    bNaviBar = BottomNaviBar();

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: () {
            if (widget.childWidget == null) {
              bNaviBar.goHome();
            } else {
              Navigator.pop(context);
            }
            
            // Navigator.push(context, CustomTransition(page: HomeScreen()));
            // Navigator.of(context).pop();
          },
        ) 
      ),

      // TODO rewrite 'AnsichtLerninhalte()'
      body: childWidget,


      bottomNavigationBar: bNaviBar,
    
    );
  }
}