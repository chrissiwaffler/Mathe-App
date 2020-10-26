import 'package:mathe_app/index.dart';

class ExceptionWidgets {

  /// dieses Widget wird angezeigt, wenn die Textdatei nicht geladen werden kann
  Widget txtLoadingError({String text=""}) {
    TextStyle style = TextStyle(
      fontFamily: "SF Pro Custom",
      fontSize: 30,
      color: Colors.redAccent
    );
    return Column(
      children: [
        Text(
          "Textdatei $text konnte nicht geladen werden!",
          style: style
        ),
        Text(
          "Sollte dieser Fehler erneut auftreten, bitte Entwickler kontaktieren!",
          style: style,
        )
      ],

      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

}