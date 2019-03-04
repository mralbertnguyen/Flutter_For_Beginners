
// Import material
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title : "Flutter Hello Word",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello this is a title of page"),
        ),
        body: Center(
          child: Text("Page's body"),
        ),
      ),
    );
  }
}
