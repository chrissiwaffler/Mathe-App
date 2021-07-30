import 'package:mathe_app/index.dart';

class BottomNaviBar extends StatefulWidget {
  BottomNaviBar() : super();

  static _BottomNaviBarState bns;

  Widget getCurrentContent() {
    return bns.getCurrentContent();
  }

  void goHome() {
    bns.goHome();
  }

  void goLerning() {
    bns.goLearning();
  }

  void goStudy() {
    bns.goStudy();
  }

  @override
  _BottomNaviBarState createState() => bns = _BottomNaviBarState();
}

class _BottomNaviBarState extends State<BottomNaviBar> {
  
  double getButtomBarIconSize() {
    return 30.0;
  }

  double getButtomBarFontsize() {
    if (Helper().getDeviceType() == 'tablet') {
      if (isHorizontal()) return 17.0;
      else return 25;
    }
    else {
      if (isHorizontal()) return 15;
      else return 15;
    }

  }

  TextStyle getTextStyleButtomBar() {
    return TextStyle(
      fontFamily: "SF Pro Custom",
      fontWeight: FontWeight.w600,
      fontSize: getButtomBarFontsize()
    ); 
  }

  // für die Navigationsleiste unten
  static int _selectedIndex = 0;

  final List<Widget> _tabs = [HomeScreen(), Lernteil(), Quiz()];


  Widget currentBody;

  static List<int> _history = [0];

  bool isHorizontal() {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    return currentOrientation == Orientation.landscape ? true : false;
  }

  @override
  void initState() {
    updateCurrentBody();
  }

  Future<void> updateCurrentBody() async {
    setState(() {
      currentBody = _tabs[_selectedIndex];
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index != _selectedIndex) {
        _history.add(index);
        _selectedIndex = index;
        updateCurrentBody();
        Navigator.push(context, CustomTransition(page: _tabs[index]));
      }
    });
  }

  Widget getCurrentContent() {
    return _tabs[_selectedIndex];
  }

  void goHome() {
    _onItemTapped(0);
  }

  void goLearning() {
    _onItemTapped(1);
  }

  void goStudy() {
    _onItemTapped(2);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: color_bottom_bar_app,

      // TODO maybe change back to BottomNavigationBarType.fixed
      type: BottomNavigationBarType.shifting,

      selectedFontSize: getButtomBarFontsize()+5,
      selectedItemColor: Colors.black,
      unselectedFontSize: getButtomBarFontsize(),

      selectedLabelStyle: getTextStyleButtomBar().copyWith(fontSize: getTextStyleButtomBar().fontSize+5),
      unselectedLabelStyle: getTextStyleButtomBar(),

      showSelectedLabels: true,
      showUnselectedLabels: !isHorizontal() && Helper().getDeviceType() == 'phone' ? false : true,

      unselectedItemColor: Color.fromRGBO(0, 0, 0, 0.5),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(

          icon: ImageIcon(AssetImage("assets/images/HomeIcon.png"), size: getButtomBarIconSize()),
          label: "Home",
          tooltip: "Zuhause :)",        
          backgroundColor: color_bottom_bar_app  
          ),

        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/StudyIcon.png"), size: getButtomBarIconSize()), 
            label: "Lernen",
            tooltip: "Interessantes Lernen :)",
            backgroundColor: Colors.white
            ),

        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/ExerciseIcon.png"), size: getButtomBarIconSize()-7), 
            label: "Üben",
            tooltip: "Schwierige Aufgaben meistern :)",
            backgroundColor: color_top_bar_app
            ),

      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}