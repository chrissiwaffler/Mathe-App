import 'package:flutter/cupertino.dart';
import 'package:mathe_app/index.dart';
import 'package:mathe_app/website_viewer_geht_nicht.dart';

class AnsichtLerninhalt extends StatefulWidget {
  AnsichtLerninhalt() : super();

  String topicTitle;
  String mainPath;

  void setTopicTitle(String t) {
    topicTitle = t;
  }

  void setMainPath(String m) {
    mainPath = m;
  }

  @override
  _AnsichtLerninhaltState createState() => _AnsichtLerninhaltState();
}

class _AnsichtLerninhaltState extends State<AnsichtLerninhalt> {

  // Name des Themengebiets
  // String topicTitle;

  int _currentPage, _maxPages;
  bool _nextPage;

  static BottomNaviBar bNaviBar;

  // _AnsichtLerninhaltState({this.topicTitle});
  
  @override
  void initState() { 
    super.initState();
    _currentPage = 0;
    _nextPage = false;
    bNaviBar = BottomNaviBar();
    _scrollController = ScrollController();
  }

  Widget title() {
    return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: FittedBox(
          child: Text(
            widget.topicTitle,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "SF Pro Custom",
              fontSize: 50,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
    );
  }

  Future<String> _loadLerninhalteString() async {
    String txt = await rootBundle.loadString('${widget.mainPath}${widget.topicTitle}.txt');
    // List <String> list = LineSplitter().convert(txt).toList();
    return txt;
  }

  Future<List<List<String>>> _loadLerninhalteList() async {
    // String txt = await rootBundle.loadString('${widget.mainPath}${widget.topicTitle}.txt');

    // List<String> sites = txt.split("</s>");

    // List<List<String>> sites_lines = [];
    // sites.forEach((site) {
    //   List<String> lines = LineSplitter().convert(site).toList();
    //   sites_lines.add(lines);
    // });

    List<List<String>> sites_lines = await TxtFileLoader().loadWithSites("${widget.mainPath}${widget.topicTitle}.txt");


    // List<String> list = LineSplitter().convert(txt).toList();
    // list.removeWhere((element) => element == "\s");

    setState(() {
      _maxPages = sites_lines.length;
      if (_maxPages > 1 && _currentPage < _maxPages-1) _nextPage = true; else _nextPage = false;
    });
    return sites_lines;

    // setState(() {
    //   _maxPages = list.length;
    //   if (_maxPages > 1 && _currentPage < _maxPages-1) {
    //     _nextPage = true;
    //   } else {
    //     _nextPage = false;
    //   }
    // });
    // return list;
  }

  Widget currentSiteText() {
    return FutureBuilder(
      future: _loadLerninhalteList(),
      builder: (context, AsyncSnapshot<List<List<String>>> snapshot) {
        if (snapshot.hasError) {
          // TODO return: show error widget
        }
      List<List<String>> sitesLines = snapshot.data ?? "";

    // List<List<String>> sitesLines = await _loadLerninhalteList();

      List<Widget> list_texts_current_site = [];

      // for (int i = 0; i < sitesLines[_currentPage].length; ++i) {        
      // }

      sitesLines[_currentPage].forEach((line) {
        if (line.contains(".png")) {
          list_texts_current_site.add(getImage(line));
        } else {
          List<TextSpan> lineNewWords = List();
          line.split(" ").forEach((word) {
            bool underline2 = false;
            var kle = line.split(" ");
            int cur_index = kle.indexOf(word);
            if (cur_index < kle.length-1) {
              if (kle[cur_index+1].contains("<u>")) {
                underline2 = true;
              }
            }


            bool bold = false;
            bool underline = false;
            if (word.contains("<b>")) {
              word = word.replaceAll("<b>", "");
              bold = true;
            } 
            if (word.contains("<u>")) {
              word = word.replaceAll("<u>", "");
              underline = true;
            }

            lineNewWords.add(TextSpan(
              text: word,
              style: TextStyle(
                decoration: underline ? TextDecoration.underline : TextDecoration.none,
                fontSize: 30,
                fontFamily: "SF Pro Custom",
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                color: Colors.black,
              )
            ));

            
            // if (line.split(" ").toList()[line.split(" ").toList().indexOf(word) + 1].contains("<u>")) underline2 = true;
            // Hinzufügen eines Leerzeichens
            lineNewWords.add(TextSpan(
              text: " ",
              style: TextStyle(
                decoration: underline2 ? TextDecoration.underline : TextDecoration.none,
                fontSize: 30,
                fontFamily: "SF Pro Custom",
                fontWeight: FontWeight.normal,
                color: Colors.black,
              )
            ));
          });

          list_texts_current_site.add(
            RichText(
              text: TextSpan(
                children: lineNewWords,
              )
            )
          );
        }
      });

      return Column(
        children: list_texts_current_site,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      );
    });

    // return FutureBuilder(
    //   future: _loadLerninhalteList(),
    //   builder: (context, AsyncSnapshot<List<List<String>>> snapshot) {
    //     if (snapshot.hasError) {
    //       // TODO return: show error widget
    //     }

    //     List<List<String>> sites_lines = snapshot.data ?? "";
        
    //     return Container(
    //       child: Text(
    //         textList[_currentPage], 
    //         style: TextStyle(
    //           fontSize: 30,
    //           fontFamily: "SF Pro Custom",
    //           fontWeight: FontWeight.normal,
    //           color: Colors.black,
    //         ),
    //       ),

    //     );
    //   },
    // );
  }
  
  // Widget currentSiteText() {
  //   Widget childWidget = HtmlLoader(
  //     mainPath: widget.mainPath,
  //     topicTitle: widget.topicTitle,
  //     context: context, 
  //     fontSize: 20, 
  //     fontWeight: FontWeight.normal, 
      
  //   ).getHtmlWidget();

  //   return childWidget;
  // }

  // Widget currentSiteText() {
  //   List<Widget> widgetsList = List<Widget>();
  //   // TODO hier weiter
  //   return FutureBuilder(
  //     future: TxtFileLoader().loadHtmlWithImages('${widget.mainPath}${widget.topicTitle}.txt'),
  //     builder: (context, AsyncSnapshot <List<String>> snapshot) {
        
  //       List<String> listTexts = snapshot.data ?? [];
  //       print("0");
  //       listTexts.forEach((element) {
  //         if (element.contains("1.png")) {
  //           // load and display photo
  //           widgetsList.add(getImage(element));
  //         } else {
  //           widgetsList.add(HtmlLoader(
  //             context: context, 
  //             fontSize: 20, 
  //             fontWeight: FontWeight.normal,
  //             text: element 
              
  //           ).getHtmlWidget());
  //         }

  //         widgetsList.add(SizedBox(height: 20));
  //       });

  //       return Column(
  //         children: widgetsList,
  //       );
  //       // return childWidget;
  //     }
  //   );

  //   // return childWidget;

  //   // return HelpScreen();
  // }

  Widget getImage(String name) {
    return Image(
      image: AssetImage("assets/data/lernteil/$name"), 
      width: MediaQuery.of(context).size.width*0.4,
    );
  }
  
  bool isHorizontal() {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    return currentOrientation == Orientation.landscape ? true : false;
  }
  
  /// define the maximum height and width of the container with the text
  double textBoxMaxHeight() {
    double factor = isHorizontal() ? 0.55 : 0.65; 
    return MediaQuery.of(context).size.height * factor;
  }

  double textBoxMaxWidth() {
    double factor = isHorizontal() ? 1 : 1;
    return MediaQuery.of(context).size.width * factor;
  }

  Widget textBox() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: textBoxMaxHeight(),
        maxWidth: textBoxMaxWidth()
      ),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(30),
        // color: Colors.white,
        // height: MediaQuery.of(context).size.height/2,
        // width: MediaQuery.of(context).size.width-leftPaddingRow*2,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          color: Colors.white,
          boxShadow: [BoxShadow(
            color: color_shadow,
            blurRadius: 30.0,
            offset: Offset(10, 10)
          )]
        ),

        child: SingleChildScrollView(
          controller: _scrollController,
          child: currentSiteText(),
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics()
        )
        // child: currentSiteText()
      ),
    );
  }

  ScrollController _scrollController;

  void _goBack() {
    if (_currentPage == 0) {
      // go back to the list
      Navigator.pop(context);
    } else {
      setState(() {
        _currentPage--;
        if (_maxPages > 1) {
          _nextPage = true;
        }
      });
      
    }
    _scrollController.animateTo(MediaQuery.of(context).size.height*1.2, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
  void _goNext() {
    // TODO implementation of button
    setState(() {
      if (_currentPage < _maxPages-1) {
        _currentPage++;
      }
      if (_nextPage == false) {
        showFinished();
      } 
      if (_currentPage == _maxPages-1) {
        _nextPage = false;
      }
      _scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  
  // Dialog, der angezeigt wird, falls alle Seiten des Kapitels gesehen wurden
  void showFinished() {
    showDialog(
      context: context,
      builder: (BuildContext c) {
        // change von AlertDialog zu CupertinoAlertDialog
        return CupertinoAlertDialog(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(20)),
          //   side: BorderSide(
          //     color: Colors.white,
          //     width: 5
          //   )
          // ),
          
          // backgroundColor: color_background,
          title: Text("Geschafft!"),
          content: Text("Zurück zur Übersicht?"),
          actions: [
            // Nein-Button
            FlatButton(
              child: Text(
                "Nein",
                style: TextStyle(
                  fontFamily: "SF Pro Custom",
                  color: color_bottom_bar_app
                )
              ),
              onPressed: () {
                Navigator.of(c).pop();
              },
            ),
            // Ja-Button
            FlatButton(
              child: Text(
                "Ja",
                style: TextStyle(
                  fontFamily: "SF Pro Custom",
                  color: Colors.black
                ),
              ),
              onPressed: () {
                Navigator.of(c).pop();
                Navigator.of(context).pop();
              },
            )            
          ],
        );
      }
    );
  }


  Widget button_sample(String text, bool isLeftButton) {
    return Container(
      child: RaisedButton(
        color: color_button_lernteil,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: Colors.transparent,
          )
        ),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        highlightElevation: 5,
        // highlightColor: Colors.green,
        

        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "SF Pro Custom",
            fontWeight: FontWeight.w500,
            fontSize: 30
          )
        ),

        onPressed: () {
          isLeftButton ? _goBack() : _goNext();
        },
      ),


      // shadow for button -> wrap in container
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [BoxShadow(
          color: color_shadow,
          blurRadius: 20,
          offset: Offset(5, 5)
        )]
      ),
    );
  }


  Widget leftButton() {
    return button_sample("Zurück", true);
  }

  Widget rightButton() {
    if (_nextPage) {
      return button_sample("Weiter", false);
    } else {
      return button_sample("Fertig", false);
    }
  }

  Widget buttonsRow() {
    return Row(
      children: [
        leftButton(),
        rightButton()
      ],
      // TODO check Abstand
      
    );
  }

  static const double leftPaddingRow = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_hintergrund_lernteil,
      body: Padding(
        padding: const EdgeInsets.only(left: leftPaddingRow, top: 30, right: leftPaddingRow),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            title(),
            SizedBox(height: 20),
            textBox(),
            SizedBox(height: 30),
            // buttonsRow()

            Row(
              children: [
                // left button
                button_sample("Zurück", true),

                // right button
                _nextPage ? button_sample("Weiter", false) : button_sample("Fertig", false)
              ],

              // TODO check Alignment
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            )
          ],
        ),
      ),


      bottomNavigationBar: bNaviBar,
    );
  }
}
