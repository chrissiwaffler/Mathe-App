import 'package:mathe_app/index.dart';

class Helper {


  Future<int> getNumberTasks(String path) async {
    int numGesamt = 0;
    List<String> l = await TxtFileLoader().loadSplittedLines(path, true);
    for (int j = 0; j < l.length; ++j) {
      if (l[j].contains("tasks:")) {
        numGesamt = l.length - j -1;
      }
    }
    return numGesamt;
  }

  Future<List<List<int>>> loadSchwierigkeitenList(String fullPath) async {
    List<String> list = await TxtFileLoader().loadSplittedLines(fullPath, false);
    
    List<List<int>> arr = new List(list.length);
    
    for (int i = 0; i < list.length; ++i) {
      String e = list[i];
      if (e.contains(":")) {
        // Nummerierung beginnt mit 1, daher wird 1 subtrahiert
        int index = int.parse(e[0]) -1;
        arr[index] = new List();
        ++i;

        do {
          // Aufgaben mit dem Schwierigkeitsgrad werden geladen
          if (i >= list.length) break;
          String d = list[i];
          if (d != "") {
            int schwierigkeitsgrad = int.parse(d[0]);
            arr[index].add(schwierigkeitsgrad);
          } else break;
          ++i;
        } while(true);
      }
    }

    // restliche null-Elemente entfernen
    for (int i = 0; i < arr.length; i++) {
      if (arr[i] == null) {
        arr = arr.sublist(0, i);
        break;
      }
    }

    return arr;
  }

  // gibt 2 int-Werte zurück:
  // die Anzahl der gelösten Aufgaben und die Anzahl der gesamten Aufgaben
  Future<List<int>> getInfoAufgaben(String path) async {
    var prefs = await SharedPreferences.getInstance();
    int numGeloest = prefs.getInt(path + "r");
    int numAufgaben = prefs.getInt(path + "g");
    return [numGeloest, numAufgaben];
  }

    String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' :'tablet';
  }

}