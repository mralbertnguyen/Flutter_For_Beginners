import 'package:flutter/material.dart';


class ItemsMainListOption extends StatelessWidget{

  String data;
  ItemsMainListOption(this.data);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: Colors.green,
      margin: EdgeInsets.all(10),
      child: Container(
        child: Text(data),
      ),
    );
  }
}
