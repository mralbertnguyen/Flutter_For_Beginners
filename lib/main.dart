import 'package:flutter/material.dart';
import 'package:flutter_app/ui/home.dart';
import 'package:flutter_app/ui/signin.dart';

import './resources/database.dart';
import './models/user_model.dart';

import 'dart:async';
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

  // handle sigin
  void _signInNewAccount(){
    // change to main screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }
  // Function check login
  void _checkInfoLogin() async{
    final String _username = userNameController.text;
    final String _password = passwordController.text;

    if(_checkIsNotNull(_username, _password)){
      var resultCheckExisted = await _checkIsExisted(_username, _password);

      Map parsedJson = resultCheckExisted.toJson();
      String parsedPassword = parsedJson.values.toList()[1];

      if(resultCheckExisted != null){
        if(_checkIsCorrect(_password,parsedPassword)){
          _loginSucess();
        }else{
          print("Wrong password");
        }
      }else{
        print("Result: null");
      }

    }
  }

  bool _checkIsNotNull (String username, String password){
    if(username.isEmpty && password.isEmpty){
      return false;
    }

    return true;
  }

 Future<User_Model> _checkIsExisted(String username, String pwd) async {

    User_Model model = new User_Model();

    model = await DBProvider.db.getUser(username);

    return model;
  }
  bool _checkIsCorrect(String currentPwd, String pwdGetInDatabase){
    if(currentPwd.compareTo(pwdGetInDatabase) == 0){
      return true;
    }
    return false;
  }



  void _loginSucess(){
    print("Login success");
    // change to main screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
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
      appBar: AppBar(
        title: new Text("Login"),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            _inputTextField("User name: ", userNameController, false),
            _inputTextField("Password: ", passwordController, true),
            buttonForm()
          ],
        ),
      )
    );
  }

  Row buttonForm() {
    return Row(
      children: <Widget>[
        _button("Log in",  _checkInfoLogin),
        _button("Sign up", _signInNewAccount)
      ],
    );
  }

  TextField _inputTextField(String placholder, TextEditingController controller, bool obscureText){
    return TextField(
      textAlign: TextAlign.left,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: placholder,
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

