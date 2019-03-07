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

  ///Generate MD5 hash
  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    print("data: "+data + "\n" + "after decode: "+ digest.toString());

    return hex.encode(digest.bytes);
  }

}
