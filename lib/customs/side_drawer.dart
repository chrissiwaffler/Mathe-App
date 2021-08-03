import 'package:mathe_app/index.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue
            ),
            child: Text("Mathe App"),
          ),
          ListTile(
            title: const Text("Item 1"),
            onTap: () => {print("hello")},
          ),
          ListTile(
            title: const Text("Item 2"),
            onTap: () => {print("hello")},
          )
        ]
      ),
    );
  }
}