// import 'package:mathe_app/index.dart';

// class ListeLerninhalte extends StatefulWidget {
//   ListeLerninhalte({Key key}) : super(key: key);

//   @override
//   _ListeLerninhalteState createState() => _ListeLerninhalteState();
// }

// class _ListeLerninhalteState extends State<ListeLerninhalte> {
  
//   Future<List<String>> _loadLerninhalteList() async {
//     String txt = await rootBundle.loadString('assets/data/liste_lerninhalte.txt');
//     List <String> list = LineSplitter().convert(txt).toList();
//     list.removeWhere((item) => item=="" || item==" ");
//     return list;
//   }


//   Widget makeCard(String heading, String subtitle) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => new AnsichtLerninhalt(topicTitle: heading)));},
//       child: ClipRRect(
//       // Radius der Kante des Schatten
//       borderRadius: BorderRadius.circular(10.0),
//       child: Card(
//         // Radius der Kante der Karte (der Farbe)
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         clipBehavior: Clip.antiAlias,
//         elevation: 8.0,
//         margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.indigo[400], ),
//           child: makeListTile(heading, subtitle)
//         )))
//     );
//   }

//   Widget makeListTile(String heading, String subtitle) {
//     return ListTile(
//       contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),  
//       leading: Container(
//         padding: EdgeInsets.only(right: 12.0),
//         decoration: new BoxDecoration(
//           border: new Border(
//             right: new BorderSide(width: 2.0, color: Colors.greenAccent))),
//         child: Icon(Icons.blur_on, color: Colors.yellow),
//       ),
//       title: Text(
//         heading,
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//       ),
//       subtitle: Row(
//         children: <Widget>[
//           Icon(Icons.linear_scale, color: Colors.yellowAccent),
//           Text(subtitle, style: TextStyle(color: Colors.white),)
//         ],
//       ),
//       trailing: Icon(Icons.keyboard_arrow_right, color: Colors.greenAccent, size: 30,));
//   }
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _loadLerninhalteList(),
//       builder: (context, AsyncSnapshot<List<String>> snapshot) {
        
//         if(snapshot.hasError) {
//           // TODO return: show error widget
//         }
//         List<String> liste = snapshot.data ?? [];
//         return ListView.builder(
//           itemCount: liste.length,
//           itemBuilder: (BuildContext context, int index) {
//             return makeCard('${liste[index]}', " >Untertitel< ");
//           },
//           padding: const EdgeInsets.all(8),
//          );
      
//     });
//   }
// }