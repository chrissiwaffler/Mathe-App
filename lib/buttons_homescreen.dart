import 'package:mathe_app/index.dart';
class ButtonsHomescreen extends RaisedButton{

  String title;
  Color colorContent, colorBorder;
  Widget destination;
  Color colorTitle;

  ButtonsHomescreen(String title, Color colorContent, Color colorBorder, Color colorTitle, Widget destination) {
    this.title = title;
    this.colorContent = colorContent;
    this.colorBorder = colorBorder;
    this.colorTitle = colorTitle;
    this.destination = destination;
  }

  @override
  Widget build(BuildContext context) {    
    return Container( 
      padding: EdgeInsets.only(top: 50, right: 20),
      
      child: RaisedButton(
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: colorBorder,
            width: 5,

          ), 
        ),
        color: colorContent,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 50,
            color: colorTitle,
          ),
        ),    
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination)
          );
        },
      )
    );

  }


}