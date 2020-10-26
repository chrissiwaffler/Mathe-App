import 'package:mathe_app/index.dart';

class CustomTransition extends PageRouteBuilder {
  final Widget page;
  CustomTransition({this.page})
    : super(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          page,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) =>
          FadeTransition(
            opacity: animation,
            child: child,
          ),
    );
}

class CustomTransitionSplashScreen extends PageRouteBuilder {
  final Widget page;
  CustomTransitionSplashScreen({this.page})
    : super(
      transitionDuration: Duration(seconds: 2),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          page,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) =>
          FadeTransition(
            opacity: animation,
            child: child,
          ),
    );
}