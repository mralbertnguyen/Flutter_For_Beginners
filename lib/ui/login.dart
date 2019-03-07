import 'package:flutter/material.dart';
import 'package:flutter_app/ui/home.dart';
import 'package:flutter_app/ui/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/database.dart';
import '../models/user_model.dart';

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

  bool isLogin ;

  @override
  void dispose() {
    // TODO: implement dispose
    // Clean up controller when Widget is disposed
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _checkIsLogin();
  }

  // handle register new account
  void _signInNewAccount(){
    // change to main screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }

  // Function check login
  void _checkInfoLogin() async{
    // Check user login or not
      final String _username = userNameController.text;
      final String _password = passwordController.text;

      if(_checkIsNotNull(_username, _password)){
        var resultCheckExisted = await _checkIsExisted(_username, _password);

        Map parsedJson = resultCheckExisted.toJson();
        // Get password from result
        String parsedPassword = parsedJson.values.toList()[1];

        if(resultCheckExisted != null){
          if(_checkIsCorrect(_password,parsedPassword)){
            _rememberLogin();
          }else{
            print("Wrong password");
          }
        }else{
          print("Result: null");
        }

      }else{
        print("User name and password null");
      }

  }

  bool _checkIsNotNull (String username, String password){
    if(username.isEmpty && password.isEmpty){
      return false;
    }
    return true;
  }

  Future<UserModel> _checkIsExisted(String username, String pwd) async {

    UserModel model = new UserModel();

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

  void _rememberLogin() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLogin", true);
      _loginSucess();
  }

   void _checkIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool("isLogin") == true){
      // User was login
      _loginSucess();
    }else{
      print("Not login before");
    }

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

