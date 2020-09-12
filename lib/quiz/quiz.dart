import 'package:mathe_app/index.dart';

class Quiz extends StatefulWidget {
  Quiz(): super();

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  BottomNaviBar bNaviBar;

  @override
  void initState() {
    bNaviBar = BottomNaviBar();
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
            bNaviBar.pop();
            // Navigator.of(context).pop();
          },
        ) 
      ),

      bottomNavigationBar: bNaviBar,
    
    );
  }
}