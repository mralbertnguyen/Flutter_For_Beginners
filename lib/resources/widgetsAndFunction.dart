import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';
import 'dart:convert';


class WidgetsFunctions extends StatefulWidget{
  WidgetsFunctions({Key key, this.title}) : super(key:key);
  final String title;
  @override
  WidgetAndFunctionState createState() => new WidgetAndFunctionState();
}

class WidgetAndFunctionState extends State<WidgetsFunctions>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
  final Color mainColor = Color.fromRGBO(64, 75, 96, .9);
  final Color whiteColor = Color.fromARGB(255, 255, 255, 255);
  ///Generate MD5 hash
  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    print("data: "+data + "\n" + "after decode: "+ digest.toString());

    return hex.encode(digest.bytes);
  }

  customDialog(String title, String content, BuildContext screenContext){
    showDialog(
        context: screenContext,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions: <Widget>[
              new FlatButton(onPressed: (){
                Navigator.of(context).pop();
              },
                  child: new Text("Close"))
            ],
          );
        }
    );
  }

  SnackBar customSnackBar(String message){
    return SnackBar(
        content: new Text(message),
        backgroundColor: Color.fromRGBO(64, 75, 96, .9)

    );

  }
  ButtonTheme button(String btnTitle, Function function) {
    return ButtonTheme(
      minWidth: 250,
      height: 60,
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: RaisedButton(
          onPressed: () {
            function();
          },
          materialTapTargetSize: MaterialTapTargetSize.padded,
          color: mainColor,
          child: Text(btnTitle,style: TextStyle(color: whiteColor, fontSize: 20,),),
        ),
      ),
    );
  }

  Text customTitleAsLogo(String msg) {
    return Text(
      msg
    );
  }
}
