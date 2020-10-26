import 'package:mathe_app/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mathe App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          primaryColor: Colors.cyan[600],
          accentColor: Colors.lightGreen[500],
          textTheme: GoogleFonts.expletusSansTextTheme(
            Theme.of(context).textTheme,
          )),

      // ? Hier auf SplashScreen() wechseln, um die SplashScreen Animation anzuzeigen
      home: Home(),
      
    );  
  }
}