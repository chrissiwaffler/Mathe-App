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
//         color: Colors.transparent,
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white
//           ),
          
//           child: makeListTile(heading, subtitle)
//         )))
//     );
//   }

//   double left_padding_list_text = 20.0;
  

//   Widget makeListTile(String heading, String subtitle) {
//     return ListTile(
//       contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),  
      
//       // linker Container
//       leading: ConstrainedBox(
//         constraints: BoxConstraints(
//           // maxWidth: MediaQuery.of(context).size.width * 0.0,
//           maxWidth: MediaQuery.of(context).size.width * 0.04
//         ),
//         child: Container(
          
//           // padding: EdgeInsets.only(right: 10.0),
//           alignment: Alignment.center,
//           decoration: new BoxDecoration(
//             // border: new Border(
//             //   right: new BorderSide(
//             //     width: 2.0, color: Colors.greenAccent
//             //   ),
//             // )
//           ),
          
//           // Symbol links
//           child: Icon(
//             Icons.blur_on,
//             color: color_list_arrow,
//             size: 25,
//           ),
//         ),
//       ),

//       // Überschrift
//       title: Container(
//         padding: EdgeInsets.only(left: left_padding_list_text),
//         decoration: BoxDecoration(
//           border: Border(
//             left: BorderSide(
//               width: 2.0, color: color_left_border_list_text
//             )
//           )
//         ),
//         child: Text(
//           heading,
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600,
//             fontFamily: "SF Pro Custom",
//             fontSize: 25,
//             letterSpacing: 0.6
//           ),
//         ),
//       ),

//       // Leiste unter dem Titel
//       subtitle: Container(
//         padding: EdgeInsets.only(left: left_padding_list_text),
//         decoration: BoxDecoration(
//           border: Border(
//             left: BorderSide(
//               width: 2.0, color: color_top_bar_app
//             )
//           )
//         ),

//         child: Row(
//           children: <Widget>[
//             Icon(
//               Icons.linear_scale,
//               color: color_list_arrow
//             ),
            
//             // Untertitel
//             Text(
//               subtitle,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontFamily: "SF Pro Rounded",
//                 fontWeight: FontWeight.w400
//               ),
//             )
//           ],
//         ),
//       ),

//       // Symbol rechts
//       trailing: Icon(
//         Icons.keyboard_arrow_right,
//         color: color_list_arrow,
//         size: 60,
//       )
//     );
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
//             return makeCard('${liste[index]}', " <Untertitel> ");
//           },
//           padding: const EdgeInsets.all(8),
//          );
      
//     });
//   }
// }