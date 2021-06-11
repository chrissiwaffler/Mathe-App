import 'package:flutter/cupertino.dart';
import 'package:mathe_app/index.dart';
// import 'package:mathe_app/website_viewer_geht_nicht.dart';

class AnsichtLerninhalt extends StatefulWidget {
  AnsichtLerninhalt({this.topicTitle, this.mainPath}) : super();

  final String topicTitle;
  final String mainPath;

  @override
  _AnsichtLerninhaltState createState() => _AnsichtLerninhaltState();
}

class _AnsichtLerninhaltState extends State<AnsichtLerninhalt> {

  int _currentPage, _maxPages;
  bool _nextPage;

  static BottomNaviBar bNaviBar;
  
  @override
  void initState() { 
    super.initState();
    _currentPage = 0;
    _nextPage = false;
    bNaviBar = BottomNaviBar();
    _scrollController = ScrollController();
  }

  /// Widget zum Anzeigen der Überschrift (Titel des aktuellen Lernthemas)
  Widget title() {
    return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: FittedBox(
          child: Text(
            // Attribut vom Widget (Titel des Topics) wird als Text angezeigt
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

  /// Laden des Textes der Lerneinheit aus einer Textdatei, die mit '</s>' nach Seiten sortiert ist
  Future<List<List<String>>> _loadLerninhalteList() async {
    // Laden aller einzelnen Seiten
    List<List<String>> sitesLines = await TxtFileLoader().loadWithSites("${widget.mainPath}${widget.topicTitle}.txt");

    setState(() {
      _maxPages = sitesLines.length;
      if (_maxPages > 1 && _currentPage < _maxPages-1) _nextPage = true; else _nextPage = false;
    });

    return sitesLines;
  }

  Widget currentSiteText() {
    return FutureBuilder(
      future: _loadLerninhalteList(),
      builder: (context, AsyncSnapshot<List<List<String>>> snapshot) {
        if (snapshot.hasError) {
          // Fehlermeldung wird angezeigt
          return ExceptionWidgets().txtLoadingError(text: "${widget.mainPath} ${widget.topicTitle}");        
        }
      List<List<String>> sitesLines = snapshot.data ?? "";

      List<Widget> listTextsCurrentSite = [];

      sitesLines[_currentPage].forEach((line) {
        // falls ein Bild eingefügt werden soll, wird dies eingefügt
        if (line.contains(".png")) {
          listTextsCurrentSite.add(getImage(line));
        } else {
          List<TextSpan> lineNewWords = List();
          line.split(" ").forEach((word) {

            // Überprüfen, ob das nächste Wort auch unterstrichen sein soll
            bool underline2 = false;
            var subList = line.split(" ");
            int currentIndex = subList.indexOf(word);
            if (currentIndex < subList.length-1) {
              underline2 = subList[currentIndex+1].contains("<u>");
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

            // neues Wort wird mit der gewünschten Formatierung erstellt
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

            // Hinzufügen eines Leerzeichens am Ende des aktuellen Wortes
            lineNewWords.add(TextSpan(
              text: " ",
              style: TextStyle(
                // das Leerzeichen ist ggf. unterstrichen (ja, falls das nächste Wort auch unterstrichen sein soll)
                decoration: underline2 ? TextDecoration.underline : TextDecoration.none,
                fontSize: 30,
                fontFamily: "SF Pro Custom",
                fontWeight: FontWeight.normal,
                color: Colors.black,
              )
            ));
          });

          // RichText wird erstellt und zur Liste hinzugefügt
          listTextsCurrentSite.add(
            RichText(
              text: TextSpan(
                children: lineNewWords,
              )
            )
          );
        }
      });

      // neue Spalte wird erstellt und zurückgegeben
      return Column(
        children: listTextsCurrentSite,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      );
    });
  }

  // Bild wird geladen und angepasst zurückgegeben
  Widget getImage(String name) {
    return Image(
      image: AssetImage("assets/data/lernteil/$name"), 
      width: MediaQuery.of(context).size.width*0.4,
    );
  }
  
  // check, ob Tablet gerade horizontal oder vertikal ist
  bool isHorizontal() {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    return currentOrientation == Orientation.landscape ? true : false;
  }
  
  /// define the maximum height and width of the container with the text
  double textBoxMaxHeight() {
    double factor = isHorizontal() ? 0.60 : 0.70; 
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
