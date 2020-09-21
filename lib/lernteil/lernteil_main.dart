import 'package:mathe_app/index.dart';

class Lernteil extends StatefulWidget {
  Lernteil() : super();

  @override
  _LernteilState createState() => _LernteilState();
}

class _LernteilState extends State<Lernteil> {
  String _documentPath = 'assets/PDFs/HandoutInformatiker.pdf';

  static const  String mainPath = "assets/data/lernteil/";

  Future<String> prepareTestPdf() async {
    final ByteData bytes =
        await DefaultAssetBundle.of(context).load(_documentPath);
    final Uint8List list = bytes.buffer.asUint8List();

    // final tempDir = await getTemporaryDirectory();
    // final tempDocumentPath = '${tempDir.path}/$_documentPath';

    // final file = await File(tempDocumentPath).create(recursive: true);
    // file.writeAsBytesSync(list);
    // return tempDocumentPath;
  }

  BottomNaviBar bNaviBar;

  @override
  void initState() {
    bNaviBar = BottomNaviBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_top_bar_app,
        title: Text(
          "Lernteil",
          style: top_bar_text_style,
        ),
        // custom arrow back
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: () {
            // bNaviBar.pop();
            bNaviBar.goHome();
            // Navigator.of(context).pop();
          },
        )
      ),
      body: Container(
        child: ListeLerninhalte(txt: "liste_lerninhalte.txt", child: AnsichtLerninhalt(), mainPath: mainPath,)
      ),

      backgroundColor: color_background,
      
      bottomNavigationBar: bNaviBar,
    
    );
  }
}

class FullPdfViewerScreen extends StatelessWidget {
  final String pdfPath;

  FullPdfViewerScreen(this.pdfPath);

  @override
  Widget build(BuildContext context) {
    // return PDFViewerScaffold(
    //     appBar: AppBar(
    //       title: Text("Document"),
    //     ),
    //     path: pdfPath);
  }
}
