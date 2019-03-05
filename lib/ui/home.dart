import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: new Center(
          child:  listViewContainer
        )
      )
    );
  }


  final listViewContainer = Container(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index){
        return _itemList;
      },
    ),
  );

  static final _itemList = Card(
    elevation: 0.8,
    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
      child: makeListTitle,
    ),
  );

  static final makeListTitle = ListTile(
    // Padding
    contentPadding: EdgeInsets.symmetric(horizontal:  20.0, vertical: 10.0),
    title: new Text("title"),
    subtitle: new Text("subtitle"),
  );
  
}
