import 'package:mathe_app/index.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://a2f38ac776c84defa34bb8a2ab9d9286@o942504.ingest.sentry.io/5891362';
    },
    appRunner: () => runApp(MyApp()),
  );
}  

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // if device is a smartphone,
    // landscape mode should be disabled
    if(Helper().getDeviceType() == 'phone') {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ]);
    }

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

      home: Home(),
    );  
  }
}