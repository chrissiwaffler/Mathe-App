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
  
  static const double buttom_bar_fontsize = 24.0;
  static const double buttom_bar_icon_size = 40.0;
  static const textstyle_buttom_bar = TextStyle(
    fontFamily: "SF Pro Custom",
    fontWeight: FontWeight.w600,
    fontSize: buttom_bar_fontsize
  );

  final _bap = BackgroundAudioPlayer();

  // für die Navigationsleiste unten
  static int _selectedIndex = 0;

  final List<Widget> _tabs = [HomeScreen(), Lernteil(), Quiz(), Settings()];

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

  void updateCurrentBody() {
    setState(() {
      currentBody = _tabs[_selectedIndex];
    });

    // falls die Home (Startseite) aktuell zu sehen ist, soll Hintergrundmusik abgespielt werden
    if (_selectedIndex == 0) {
      _bap.play();
    } else {
      _bap.pause();
    }
  }

  void pop() {
    // TODO pop to previous page
    // implement a list
    // _history.removeAt(_history.length-1);
    // Navigator.pop(context);
    // setState(() {
    //   _selectedIndex = _history[_history.length-1];
    // });

    _onItemTapped(_history[_history.length-2]);
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index != _selectedIndex) {
        _history.add(index);
        _selectedIndex = index;
        updateCurrentBody();
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => _tabs[index]));
        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => _tabs[index]));
        Navigator.push(context, CustomTransition(page: _tabs[index]));
      }
    });
  }

  Widget getCurrentContent() {
    print("Get Current Content");
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
      type: BottomNavigationBarType.fixed,

      selectedFontSize: buttom_bar_fontsize+5,
      selectedItemColor: Colors.black,
      // selectedItemColor: Colors.black,
      unselectedFontSize: buttom_bar_fontsize,

      showSelectedLabels: isHorizontal(),
      showUnselectedLabels: isHorizontal(),

      unselectedItemColor: Color.fromRGBO(0, 0, 0, 0.5),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage("assets/images/HomeIcon.png"), size: buttom_bar_icon_size),
          title: Text("Home", style: textstyle_buttom_bar)),

        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/StudyIcon.png"), size: buttom_bar_icon_size), 
            title: Text("Lernen", style: textstyle_buttom_bar)),

        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/ExerciseIcon.png"), size: buttom_bar_icon_size-7), 
            title: Text("Üben", style: textstyle_buttom_bar,)),

        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/SettingsIcon.png"), size: buttom_bar_icon_size),
            title: Text("Einstellungen", style: textstyle_buttom_bar))
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  // @override
  // void dispose() {
    
  // }
}