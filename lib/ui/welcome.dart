import 'package:flutter/material.dart';
void main () => runApp(Welcome());


class Welcome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home : new WelcomePage(title: "Welcome page",),
    );
  }
}

class WelcomePageState extends State<WelcomePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        body: new Center(
          child: new Text(widget.title),
        )
    );
  }

}

class WelcomePage extends StatefulWidget{
  WelcomePage({Key key, this.title}) : super(key:key);
  final String title;
  @override
  WelcomePageState createState() => new WelcomePageState();
}