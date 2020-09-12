import 'package:mathe_app/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mathe App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          primaryColor: Colors.cyan[600],
          accentColor: Colors.lightGreen[500],
          textTheme: GoogleFonts.expletusSansTextTheme(
            Theme.of(context).textTheme,
          )),
      home: Home(),
      
    );
  }
}
