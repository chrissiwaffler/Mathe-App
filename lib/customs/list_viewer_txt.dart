import 'package:mathe_app/index.dart';

class ListeLerninhalte extends StatefulWidget {
  ListeLerninhalte({this.txt, this.child, this.mainPath}) : super();

  // Parameter for the child widget of the MaterialPageRoute when tapping on the card
  final AnsichtLerninhalt child;

  // main path of the current directory, e.g. 'assets/data/lernteil/'
  final String mainPath;

  // Path of the txt-File with all the headings
  final String txt;

  @override
  _ListeLerninhalteState createState() => _ListeLerninhalteState();
}

class _ListeLerninhalteState extends State<ListeLerninhalte> {
  Widget childWidget;
  double leftPaddingListText = 20.0;

  @override
  void initState() { 
    super.initState();
  }

  Future<List<String>> _loadLerninhalteList() async {
    return TxtFileLoader().loadSplittedLines(widget.mainPath + widget.txt, true);
  }

  Widget createChild(String heading, String subtitle) {
    AnsichtLerninhalt childWidget;
    childWidget = AnsichtLerninhalt(topicTitle: heading, mainPath: widget.mainPath);
    return childWidget;
  }

  Widget makeCard(String heading, String subtitle) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => createChild(heading, subtitle)));},
      child: ClipRRect(
      // Radius der Kante des Schatten
      borderRadius: BorderRadius.circular(10.0),
      child: Card(
        // Radius der Kante der Karte (der Farbe)
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          
          child: makeListTile(heading, subtitle)
        )))
    );
  }

  Widget makeListTile(String heading, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),  
      
      // linker Container
      leading: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.04
        ),
        child: Container(
          alignment: Alignment.center,
          
          // Symbol links
          child: Icon(
            Icons.blur_on,
            color: color_list_arrow,
            size: 25,
          ),
        ),
      ),

      // Überschrift
      title: Container(
        padding: EdgeInsets.only(left: leftPaddingListText),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 2.0, color: color_left_border_list_text
            )
          )
        ),
        child: AutoSizeText(
          heading,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontFamily: "SF Pro Custom",
            fontSize: MediaQuery.of(context).size.width / 20,
          ),
          maxLines: 3,
          maxFontSize: 25,
        ),
      ),

      // Symbol rechts
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: color_list_arrow,
        size: 60,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadLerninhalteList(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        
        if(snapshot.hasError) {
          // TODO return: show error widget
        }
        List<String> liste = snapshot.data ?? [];
        return ListView.builder(
          itemCount: liste.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard('${liste[index]}', " <Untertitel> ");
          },
          padding: const EdgeInsets.all(8),
        );
    });
  }
}