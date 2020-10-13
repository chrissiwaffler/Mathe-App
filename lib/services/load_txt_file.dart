import 'package:mathe_app/index.dart';

class TxtFileLoader {
  

  // load a txt-file with '</s>' seperating the different sites
  Future<List<List<String>>>loadWithSites(String fullPath) async {
    fullPath = cleanFilePath(fullPath);

    String txt = await rootBundle.loadString('$fullPath');

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
    String txt = await rootBundle.loadString('$fullPath');
    return txt;
  }

  // load the given txt-file and split the different lines 
  // optional: remove the empty lines (via the paramter: 'removingEmptyLines=true')
  Future<List<String>> loadSplittedLines(String fullPath, bool removingEmptyLines) async {
    fullPath = cleanFilePath(fullPath);
    String txt = await rootBundle.loadString(fullPath);
    List <String> list = LineSplitter().convert(txt).toList();
    if (removingEmptyLines) list.removeWhere((item) => item=="" || item==" ");
    return list;
  }

  Future<List<String>> loadHtmlWithImages(String fullPath) async {
    String txt = await loadBasic(fullPath);
    List<String> listTexts = txt.split("<image>");
    return listTexts;
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