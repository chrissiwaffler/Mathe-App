import 'package:mathe_app/index.dart';

class HomeScreen extends StatefulWidget {
  final String title = "Mathe App";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BottomNaviBar bNaviBar;

  @override
  void initState() { 
    super.initState();
    bNaviBar = BottomNaviBar();
    bNaviBar.createState();
  }

  isHorizontal() {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    return currentOrientation == Orientation.landscape ? true : false;
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

  double getFontSize() {
    return MediaQuery.of(context).size.width / 12.8;
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
          fontSize: getFontSize(),
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
          fontSize: getFontSize(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      backgroundColor: color_background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: color_top_bar_app,
        title: Text(
          widget.title,
          style: top_bar_text_style,
          textAlign: TextAlign.center,
        ),
      ),

      body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 40.0, left: 20.0, right: 20.0),
              child: Text(
                "Mathematik App 10. Klasse Gymnasium",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "SF Pro Custom",
                  fontWeight: FontWeight.w300,
                  fontSize: MediaQuery.of(context).size.width / 19.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // white background container
            Expanded(
              // flex: ,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),
                    color: Colors.white,
                    boxShadow: [BoxShadow(
                      color: color_shadow,
                      blurRadius: 30.0,
                      offset: Offset(5, 5)
                    )]
                  ),

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
