import 'package:mathe_app/index.dart';

class Lernteil extends StatefulWidget {
  Lernteil() : super();

  @override
  _LernteilState createState() => _LernteilState();
}

class _LernteilState extends State<Lernteil> {

  static const  String mainPath = "assets/data/lernteil/";

  BottomNaviBar bNaviBar;

  @override
  void initState() {
    bNaviBar = BottomNaviBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_top_bar_app,
        title: Text(
          "Lernteil",
          style: top_bar_text_style,
        ),

        leading: Container(),
      ),
      body: Container(
        child: ListeLerninhalte(txt: "liste_lerninhalte.txt", mainPath: mainPath,)
      ),

      backgroundColor: color_background,
      
      bottomNavigationBar: bNaviBar,
    );
  }
}