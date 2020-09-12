import 'package:mathe_app/index.dart';


class ListeLernteil extends StatelessWidget {
  ListeLernteil({Key key}) : super(key: key);

  //factory ListeLernteilState.fromJson(Map<String, dynamic> parsedJson) {
    
    //String content_kapitel = parsedJson['Kapitel'];
    
    //}

  
  Future<String> _loadLernteilDataAsset() async {
    return await rootBundle.loadString('assets/data/lernteil.json');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}