import 'package:flutter/material.dart';

import 'dart:async';
void main() => runApp(App());

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home : new Scaffold(
        body: new Center(
          child: new Text("Main"),
        ),
      )
    );
  }
}


