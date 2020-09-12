import 'package:mathe_app/index.dart';

class AnsichtLerninhalt extends StatefulWidget {
  AnsichtLerninhalt({this.topicTitle}) : super();
  String topicTitle;
  @override
  _AnsichtLerninhaltState createState() => _AnsichtLerninhaltState(topicTitle: topicTitle);
}

class _AnsichtLerninhaltState extends State<AnsichtLerninhalt> {
  
  // Name des Themengebiets
  String topicTitle;

  _AnsichtLerninhaltState({this.topicTitle});
  
  Widget title() {
    return Text(
      topicTitle,
      style: TextStyle(
        color: Colors.black,
        fontFamily: "SF Pro Custom",
        fontSize: 70,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Future<String> _loadLerninhalteList() async {
    String txt = await rootBundle.loadString('assets/data/$topicTitle.txt');
    // List <String> list = LineSplitter().convert(txt).toList();
    return txt;
  }

  Widget textBox() {
    return FutureBuilder(
      future: _loadLerninhalteList(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasError) {
          // TODO return: show error widget
        }

        String text = snapshot.data ?? "";
        
        
        return Container(
          child: Text(
            text, 
            style: TextStyle(
              fontSize: 30
            ),
          )
        );
      },
      // child: Center(
      // child: Text(
        
      // )
      // ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_hintergrund_lernteil,
      body: Padding(
        padding: const EdgeInsets.only(left: 50, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            title(),
            textBox()
          ],
        ),
      ),
    );
  }
}
