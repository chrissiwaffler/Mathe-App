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


  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}