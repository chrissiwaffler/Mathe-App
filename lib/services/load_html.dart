import 'package:mathe_app/index.dart';

class HtmlLoader {

  HtmlLoader ({this.mainPath, this.topicTitle, this.context, this.fontSize, this.fontWeight, this.text});
  // HtmlLoader ({this.context, this.fontSize, this.fontWeight, this.text});

  final String mainPath, topicTitle;
  final BuildContext context;
  final double fontSize;
  final FontWeight fontWeight;
  
  final String text;

  // Widget getHtmlWidget() {
  //   return FutureBuilder(
  //     future: TxtFileLoader().loadBasic(this.mainPath+this.topicTitle),
  //     builder: (context, AsyncSnapshot<String> snapshot) {
  //       if (snapshot.hasError) {
  //         // TODO return: show error widget
  //       }

  //       String text = snapshot.data ?? "";

  //       return HtmlWidget(
  //         text,
  //         textStyle: TextStyle(
  //           fontSize: this.fontSize,
  //           fontFamily: "SF Pro Rounded",
  //           fontWeight: this.fontWeight
  //         ),
  //       );

  //       // return Html(
  //       //   data: text
  //       // );
  //     }
  //   );
  // } 

  Widget getHtmlWidget() {
    return HtmlWidget(
      this.text,
      textStyle: TextStyle(
        fontSize: this.fontSize,
        fontFamily: "SF Pro Rounded",
        fontWeight: this.fontWeight
      ),
    );
  } 
}