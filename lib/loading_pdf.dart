import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';

class LoadPDF extends StatefulWidget {
  LoadPDF({Key key}) : super(key: key);

  @override
  _LoadPDFState createState() => _LoadPDFState();
}

class _LoadPDFState extends State<LoadPDF> {
  
  String _documentPath = 'PDFs/HandoutInformatiker.pdf';

  Future <String> bereitePDF() async {
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
    return Container(
       child: ,
    );
  }
}