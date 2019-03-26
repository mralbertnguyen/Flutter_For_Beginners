import 'package:flutter/material.dart';

import 'package:flutter_app/ui/main.dart';
void main() => runApp(App());

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppStateFul(title: "Demo Function Flutter",);
  }
}


class AppStateFul extends StatefulWidget{
  AppStateFul({Key key, this.title}):super(key: key);

  String title;

  @override
  AppState createState() => AppState();
}

class AppState extends State<AppStateFul>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: MainStateless(),
      ),
    );
  }
}



