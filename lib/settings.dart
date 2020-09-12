import 'package:mathe_app/index.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  
  BottomNaviBar bNaviBar;

  @override
  void initState() {
    bNaviBar = BottomNaviBar();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: color_top_bar_app,
        title: Text(
          "Einstellungen",
          style: top_bar_text_style,
          textAlign: TextAlign.center,
        ),

        // custom arrow back
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: () {
            bNaviBar.pop();
            // Navigator.of(context).pop();
          },
        )
      ),



      bottomNavigationBar: bNaviBar,
    );
  }
}