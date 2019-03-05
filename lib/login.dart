import 'package:flutter/material.dart';
void main() => runApp(Login());

class Login extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home : new LoginPage(title: "hello")
    );
  }

}

class LoginPage extends StatefulWidget{
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoginPageState createState() => new LoginPageState();

}

class LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          inputTextField("User Name: "),
          inputTextField("Password: ")
        ],
        
      );
    );
  }

  static TextField inputTextField(String placholder){
    return TextField(
      decoration: InputDecoration(
        labelText: placholder
      ),
    );
  }


}

