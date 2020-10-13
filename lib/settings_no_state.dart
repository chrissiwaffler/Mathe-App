import 'package:flutter/cupertino.dart';
import 'package:mathe_app/index.dart';

class SettingsNoState {

  SettingsNoState({this.context});
  final BuildContext context;

  TextStyle popupButtonTextStyle = TextStyle(
    fontFamily: "SF Pro Custom",
    fontSize: 15
  );

  Widget resetPopup() {
    return CupertinoAlertDialog(
      title: Text(
        "Alle Zwischenstände im Quiz-Teil und alle Einstellungen werden zurückgesetzt!",
        style: TextStyle(
          fontFamily: "SF Pro Custom",
          fontSize: 15,
        )
      ),

      actions: [
        FlatButton(
          onPressed: (() => Navigator.pop(context)), 
          child: Text(
            "Abbruch",
            style: popupButtonTextStyle
          )
        ),

        FlatButton(
          onPressed: (() {
            _resetAll();
            Navigator.pop(context);
          }),
          child: Text(
            "Reset",
            style: popupButtonTextStyle,
          )
        )
      ],
    );
  }

  // Zurücksetzten der Einstellungen und des gesamten Fortschritts
  Future<void> _resetAll() async {
    // TODO
    var prefs = await SharedPreferences.getInstance();
    bool res = await prefs.clear();
    if (res) {
      // erfolgreiches Zurücksetzen
      showCupertinoDialog(context: context, builder: (BuildContext c) {
        return CupertinoAlertDialog(
          title: Text(
            "Alles erfolgreich zurückgesetzt!",
            style: TextStyle(
              fontFamily: "SF Pro Custom",
              fontSize: 20,
            ),
          ),
          
          actions: [
            FlatButton(
              child: Text(
                "Ok",
                style: popupButtonTextStyle
              ),
              onPressed: (() => Navigator.pop(c)),
            )
          ],
        );
      });
    }
  }

}