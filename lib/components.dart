import 'package:flutter/material.dart';

class Component extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ComponentPage();
  }
}

class ComponentPage extends StatefulWidget{
  ComponentPage({Key key}) : super(key:key);

  @override
  ComponentPageState createState() => new ComponentPageState();
}

class ComponentPageState extends State<ComponentPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

  TextField _inputTextField(String placholder, TextEditingController controller){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: placholder
      ),
    );
  }

  RaisedButton _button (String btnTitle, Function function){
    return RaisedButton(
      onPressed: (){
        function();
      },
      child: new Text(btnTitle),
    );
  }
}

