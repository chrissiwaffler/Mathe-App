import 'package:mathe_app/index.dart';
import 'package:mathe_app/xd_splash_animation/XD_Start1.dart';

class SplashScreen1 extends StatefulWidget {
  SplashScreen1({Key key}) : super(key: key);

  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  
  goNext() async {
    Future.delayed(
      Duration(seconds: 1),
      () {
        Navigator.push(context, CustomTransitionSplashScreen(page: SplashScreen2()));
        // Navigator.push(context, PageRouteBuilder(pageBuilder: () => SplashScreen2(), ));
      }
    ); 
  }

  @override
  Widget build(BuildContext context) {
    goNext();
    return XD_Start1();
  }
}