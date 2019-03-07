import 'package:flutter/material.dart';
import 'package:flutter_app/ui/home.dart';
import 'package:flutter_app/ui/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/database.dart';
import '../models/user_model.dart';

import '../resources/widgetsAndFunction.dart' as widgetController;

import 'dart:async';

void main() => runApp(Login());

class UserNameValidate{
  static String validate(String username){
    return username.isEmpty ? 'Please type username' : null;
  }
}

class PasswordValidate{
  static String validate(String pwd){
    return pwd.isEmpty ? 'Please type password' : null;
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home: new LoginPage(title: "hello"));
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // Create controller
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();


  bool isLogin;

  @override
  void dispose() {
    // TODO: implement dispose
    // Clean up controller when Widget is disposed
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() async{
    // TODO: implement initState
    checkIsLogin();
  }

  // handle register new account
  void signInNewAccount() {
    // change to main screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }

  // Function check login
  void checkInfoLogin() async {
    // Check user login or not
    final String _username = userNameController.text;
    // Decode password with MD5
    final String _password = widgetController.WidgetAndFunctionState().generateMd5(passwordController.text);
    if (checkIsNotNull(_username, _password)) {
      var resultCheckExisted = await checkIsExisted(_username);
      if (resultCheckExisted != null) {
        // get json
        Map parsedJson = resultCheckExisted.toJson();
        // Get password from json result
        String parsedPassword = parsedJson.values.toList()[1];
        if (resultCheckExisted != null) {
          if (checkIsCorrect(_password, parsedPassword)) {
            rememberLogin();
          } else {
            print("Wrong password");
          }
        } else {
          print("Result: null");
        }
      } else {
        print("Please create User");
      }
    } else {
      print("User name and password null");
    }
  }

  bool checkIsNotNull(String username, String password) {
    if (username.isEmpty && password.isEmpty) {
      return false;
    }
    return true;
  }

  Future<UserModel> checkIsExisted(String username) async {
    UserModel model = new UserModel();

    model = await DBProvider.db.getUser(username);

    print(model);

    return model;
  }

  bool checkIsCorrect(String currentPwd, String pwdGetInDatabase) {
    if (currentPwd.compareTo(pwdGetInDatabase) == 0) {
      return true;
    }
    return false;
  }

  void loginSuccess() {
    print("Login success");
    // change to main screen
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        ModalRoute.withName("/Login"));
  }

  void rememberLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLogin", true);
    loginSuccess();
  }

  void checkIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("isLogin") == true) {
      // User was login
      loginSuccess();
    } else {
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
        ));
  }

  Row buttonForm() {
    return Row(
      children: <Widget>[
        _button("Log in", checkInfoLogin),
        _button("Sign up", signInNewAccount)
      ],
    );
  }

  TextField _inputTextField(
    String placholder, TextEditingController controller, bool obscureText) {
    return TextField(
      textAlign: TextAlign.left,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: placholder,
      ),
    );
  }

  RaisedButton _button(String btnTitle, Function function) {
    return RaisedButton(
      onPressed: () {
        function();
      },
      child: new Text(btnTitle),
    );
  }
}
