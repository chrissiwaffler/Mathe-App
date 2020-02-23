import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:mathe_app/lernteil/liste_lerninhalte.dart';
import 'package:path_provider/path_provider.dart';

class Lernteil extends StatefulWidget {
  Lernteil({Key key}) : super(key: key);

  @override
  _LernteilState createState() => _LernteilState();
}

class _LernteilState extends State<Lernteil> {
  String _documentPath = 'assets/PDFs/HandoutInformatiker.pdf';

  Future<String> prepareTestPdf() async {
    final ByteData bytes =
        await DefaultAssetBundle.of(context).load(_documentPath);
    final Uint8List list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/$_documentPath';

    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lernteil"),
      ),
      body: Container(
        child: ListeLerninhalte()
      ),
    
    );
  }
}

class FullPdfViewerScreen extends StatelessWidget {
  final String pdfPath;

  FullPdfViewerScreen(this.pdfPath);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Document"),
        ),
        path: pdfPath);
  }
}
