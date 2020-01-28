import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class Lernteil extends StatefulWidget {
  Lernteil({Key key, this.pdfPath }) : super(key: key);

  final String pdfPath;

  @override
  _LernteilState createState() => _LernteilState(pdfPath);
}

class _LernteilState extends State<Lernteil> {
  
  final String pdfPath;
  _LernteilState(this.pdfPath);
  
  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text("Lerninhalte"),
      ),
      path: pdfPath,
    );
  }
}