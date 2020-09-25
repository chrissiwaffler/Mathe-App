import 'package:mathe_app/index.dart';

class TxtFileLoader {
  

  // load a txt-file with '</s>' seperating the different sites
  Future<List<List<String>>>loadWithSites(String fullPath) async {
    fullPath = cleanFilePath(fullPath);

    String txt = await rootBundle.loadString('$fullPath.txt');

    List<String> sites = txt.split("</s>");

    List<List<String>> sites_lines = [];
    sites.forEach((site) {
      List<String> lines = LineSplitter().convert(site).toList();
      sites_lines.add(lines);
    });

    return sites_lines;
  }

  // load a txt-file without any refactoring
  Future<String> loadBasic(String fullPath) async {
    fullPath = cleanFilePath(fullPath);
    String txt = await rootBundle.loadString('$fullPath.txt');
    return txt;
  }

  Future<List<String>> loadSplittedLines(String fullPath) async {
    fullPath = cleanFilePath(fullPath);
    String txt = await rootBundle.loadString(fullPath);
    List <String> list = LineSplitter().convert(txt).toList();
    list.removeWhere((item) => item=="" || item==" ");
    return list;
  }




  // refactor the String to have 1 '.txt' ending
  String cleanFilePath(String old) {
    if (old.contains(".txt")) {
      var list = old.split(".txt");
      return cleanFilePath(list[0]);
    } else {
      return old + ".txt";
    }
  }

}