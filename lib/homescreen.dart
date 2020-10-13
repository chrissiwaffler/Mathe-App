import 'package:mathe_app/index.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  final String title = "Mathe App";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double OFFSETBetween = 20;
  static const double OFFSETLeft = 100;

  // final buttonLernteil = ButtonsHomescreen(
  //     "Lernteil", Farbe.lernteil, Colors.white, Colors.white, Lernteil()
  //     //PDFSite()
  //     );

  // final buttonQuiz = ButtonsHomescreen(
  //     "Quiz", Farbe.quiz_aufgaben, Colors.white, Colors.white, Quiz());

  // final buttonQuizLoesungen = ButtonsHomescreen(
  //     "Lösungen", Colors.white, Farbe.quiz_loesungen, Colors.black, MyApp());

  // final buttonUebungsteil = ButtonsHomescreen(
  //   "Übungsteil",
  //   Farbe.uebungsteil_aufgaben,
  //   Colors.white,
  //   Colors.white,
  //   Uebungen(),
  // );

  // final buttonUebungsteilLoesungen = ButtonsHomescreen("Lösungen", Colors.white,
  //     Farbe.uebungsteil_loesungen, Colors.black, MyApp());

  BottomNaviBar bNaviBar;

  @override
  void initState() { 
    super.initState();
    bNaviBar = BottomNaviBar();
    bNaviBar.createState();
    // update();
  }

  isHorizontal() {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    return currentOrientation == Orientation.landscape ? true : false;
  }

  Future<int> getHeightImage() async {
    File image = new File('assets/images/StartscreenLernen.png');
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    int img_height = decodedImage.height;
    int img_width = decodedImage.width;
  }

  /// Learning Part:
  
  Widget imageLearningStudent() {
    return new Container(
      width: MediaQuery.of(context).size.width/2,
      alignment: Alignment.topCenter,
      child: Image(
        image: new AssetImage('assets/images/StartscreenStudy.png')
      ),
    );
  }

  Widget textLearningPart() {
    return new Container(
      width: MediaQuery.of(context).size.width/2,
      alignment: Alignment.topCenter,
      child: new Text(
        "Lernen",
        style: TextStyle(
          color: Colors.black,
          fontFamily: "SF Pro Custom",
          fontSize: 60,
          fontWeight: FontWeight.w800
        ),
      ),
    );
  }

  Widget learningPart() {
    return GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          textLearningPart(), 
          imageLearningStudent()
        ],
      ),

      onTap: () {
        bNaviBar.goLerning();
      },

      // onPanDown: ,
    );
  }


  /// Excersice Part:
  
  Widget imageExcersiceStudent() {
    return new Container(
      width: MediaQuery.of(context).size.width/2,
      alignment: Alignment.topCenter,
      child: Image(
        image: new AssetImage('assets/images/StartscreenExcersice.png')));
  }

  Widget textExcersicePart() {
    return new Container(
      width: MediaQuery.of(context).size.width/2,
      alignment: Alignment.topCenter,
      child: new Text(
        "Üben",
        style: TextStyle(
          color: Colors.black,
          fontFamily: "SF Pro Custom",
          fontSize: 60,
          fontWeight: FontWeight.w800
        )
      )
    );
  }

  Widget excersicePart() {
    return GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          textExcersicePart(),
          imageExcersiceStudent()
        ],
      ),

      onTap: () {
        bNaviBar.goStudy();
      },
    );
  }

  /// TOOD Borderside nur auf oberen Rand machne
  /// sonnst sind die Nachbahrn entzünt
  BorderSide border() {
    return new BorderSide(

    );
  }

  @override
  Widget build(BuildContext context) {
    var listViewOrientation =
        isHorizontal() == true ? Axis.vertical : Axis.horizontal;
    print("Horizontal: " + isHorizontal().toString());

    return Scaffold(
      backgroundColor: color_background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: color_top_bar_app,
        title: Text(
          widget.title,
          style: top_bar_text_style,
          textAlign: TextAlign.center,
        ),

        // no Leading Icon
        // leading: Padding(
        //   padding: EdgeInsets.only(left: 20.0),
        //   child: ImageIcon(AssetImage("assets/images/PiSymbol.png"),
        //     size: 20)),
        leading: Container(),
      ),

      body: Column(
          children: <Widget>[
            
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 40.0, left: 20.0, right: 20.0),
              child: Text(
                "Mathematik App für die 10. Klasse des Gymnasiums",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "SF Pro Custom",
                  fontWeight: FontWeight.w300,
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // white background container
            Expanded(
              // flex: ,
                child: Container(
                  decoration: BoxDecoration(
                    // border: Border.symmetric(
                    //   horizontal: BorderSide(color: Color.fromRGBO(0, 0, 0, 0)),
                    //   // color: 
                    // ),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),
                    // borderRadius: BorderRadius.all(Radius.circular(60)),
                    color: Colors.white,
                    boxShadow: [BoxShadow(
                      color: color_shadow,
                      blurRadius: 30.0,
                      offset: Offset(5, 5)
                    )]
                  ),

                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
                  
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      learningPart(),
                      excersicePart(),

                    ],
                  )

                ),
            )
          ]),
      
      bottomNavigationBar: bNaviBar,
      );
      
      
        
  
  }
}
