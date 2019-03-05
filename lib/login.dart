import 'package:flutter/material.dart';
import 'dart:developer';
import 'main.dart';
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

  // Create controller
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  // Account default
  final String userNameDefault = 'admin';
  final String passwordDefault = 'admin';

  // Function check login
  void _checkInfoLogin(){

    final String _username = userNameController.text;
    final String _password = passwordController.text;

    if(checkNull(_username, _password)){
      print("Null");
    }

    if(!checkIsCorrect(_username, _password)){
      print("Not Correct");
    }else{
      loginSucess();
    }

  }

  bool checkNull (String username, String password){
    if(username.length == 0 && password.length == 0){
      return true;
    }
    return false;
  }

  bool checkIsCorrect(String username, String password){
    if(username.compareTo(userNameDefault) != 0 && password.compareTo(passwordDefault) != 0){
      return false;
    }
    return true;
  }


  void loginSucess(){
    // change to main screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Clean up controller when Widget is disposed
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          inputTextField("User Name: ", userNameController),
          inputTextField("Password: ", passwordController),
          buttonFrom("Login"),
        ],
      )
    );
  }

  TextField inputTextField(String placholder, TextEditingController controller){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: placholder
      ),
    );
  }

 RaisedButton buttonFrom (String btnTitle){
    return RaisedButton(
      onPressed: (){
        _checkInfoLogin();
      },
      child: new Text(btnTitle),
    );
  }


  AlertDialog alertNotification(String title, String content){
    return AlertDialog(
      title: new Text(title),
      content: new Text(content),
    );
  }

}


//class Main extends StatelessWidget{
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return MaterialApp(
//        home : new Scaffold(
//          body: new Center(
//            child: new Text("Home page"),
//          ),
//        )
//    );
//  }
//}
