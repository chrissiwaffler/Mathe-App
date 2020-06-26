// import 'package:flutter/material.dart';
// import 'package:mathe_app/home.dart';
// import 'package:mathe_app/lernteil.dart';
// import 'package:mathe_app/profil.dart';
// import 'package:mathe_app/quiz/quiz.dart';

// class BottomNavyBar extends StatefulWidget {
//   const BottomNavyBar({Key key}) : super(key: key);

//   @override
//   _BottomNavyBarState createState() => _BottomNavyBarState();
// }

// class _BottomNavyBarState extends State<BottomNavyBar> {
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       iconSize: 30,
      
//       backgroundColor: Colors.purple[400],
//       selectedItemColor: Colors.lightBlue,
//       unselectedItemColor: Colors.white,
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.library_books), title: Text("Lernen")),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.question_answer), title: Text("Quiz")),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             title: Text("Profil"),
//             backgroundColor: Colors.blue)
//       ],
//     );
//   }

//   int _selectedIndex = 0;

//   final List<Widget> _tabs = [
//     Home(),
//     Lernteil(),
//     Quiz(),
//     Profil()
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
// }
