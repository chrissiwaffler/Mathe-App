import 'package:mathe_app/index.dart';

class Home extends StatefulWidget {
  Home() : super();

  final String title = "Mathe App";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  BottomNaviBar bNaviBar;
  Widget currentBody;

  @override
  void initState() { 
    super.initState();

  }

  void update() {
    setState(() {
      // currentBody = bNaviBar.bns.currentBody;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}  
