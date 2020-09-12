// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// class PDFSite extends StatefulWidget {
//   PDFSite({Key key}) : super(key: key);


//   @override
//   _PDFSiteState createState() => _PDFSiteState();
// }

// class _PDFSiteState extends State<PDFSite> {
//   String assetPDFPath;

  
//   @override
//   void initState() { 
//     super.initState();
    
//     getFileFromAsset("HandoutInformatiker.pdf").then((f) {
//       setState(() {
//         assetPDFPath = f.path;
//         print(assetPDFPath);
//       });
//     });

//   }


//   Future<File> getFileFromAsset(String fileName) async {
//     try{
//       var data = await rootBundle.load("assets/PDFs/{fileName}");
//       var bytes = data.buffer.asUint8List();
//       var dir = await getApplicationDocumentsDirectory();
//       File file = File("${dir.path}/{fileName}");

//       File assetFile = await file.writeAsBytes(bytes);
//       return assetFile;
//     } catch (e) {
//       throw Exception("Error opening asset file");
//     }

//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        child: Container(),
//     );
//   }
// }


// class PDFViewPage extends StatefulWidget {
//   final String path;

//   PDFViewPage({Key key, this.path}) : super(key: key);

//   @override
//   _PDFViewPageState createState() => _PDFViewPageState();
// }

// class _PDFViewPageState extends State<PDFViewPage> {
//   int _totalPages = 0;
//   int _currentPage = 0;
//   bool pdfReady = false;
//   PDFViewController _pdfViewController;
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("PDF Ansicht"),
//       ),
//       body: Stack(children: <Widget>[
//         PDFView(
//           filePath: widget.path,
//           autoSpacing: true,
//           enableSwipe: true,
//           pageSnap: true,
//           swipeHorizontal: true,
//           onError: (e) {
//             print(e);
//           },
//           onRender: (_pages){
//             setState(() {
//               _totalPages = _pages;
//               pdfReady = true;
//             });
//           },

//           onViewCreated: (PDFViewController vc) {
//             _pdfViewController = vc;
//           },

//           onPageChanged: (int page, int total) {
//             setState(() {

//             });
//           },

//           onPageError: (page, e){

//           },
//         ),

//         !pdfReady?Center(child: CircularProgressIndicator(),):Offstage()
         
//       ],),

//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,

//         children: <Widget>[

//           _currentPage>0?FloatingActionButton.extended(
//             backgroundColor: Colors.red,
//             onPressed: (){
//               _currentPage -= 1;
//               _pdfViewController.setPage(_currentPage);
//             },
//             label: Text("Go to ${_currentPage-1}"),
//           ):Offstage(),

//           _currentPage<_totalPages?FloatingActionButton.extended(
//             backgroundColor: Colors.green,
//             onPressed: (){
//               _currentPage += 1;
//               _pdfViewController.setPage(_currentPage);
//             },
//             label: Text("Go to ${_currentPage+1}"),

//           ):Offstage(),

//       ],),
//     );
  
//   }
// }