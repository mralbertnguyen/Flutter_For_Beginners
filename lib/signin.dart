import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_model.dart';

class SignIn extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home : new SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget{
  SignInPage({Key key}) : super(key: key);
  @override
  SignInPageSate createState() => new SignInPageSate();
}

class SignInPageSate extends State<SignInPage>{

  // Create controller for editext
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController retypePasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Sign in"),
      ),
      body: new Column(
        children: <Widget>[
          _inputTextField("User name", usernameController, false),
          _inputTextField("Password", passwordController, true),
          _inputTextField("Retype password", retypePasswordController, true),
          _buttonForm(),
        ],
      ),
    );
  }

  void _finishSignIn(){
    // Get user name and password
    final String username = usernameController.text;
    final String password = passwordController.text;
    final String retype = retypePasswordController.text;

    if(!_checkIsSamePassword(password, retype)){
      print("Please check password again");
    }else{
      _handleStorageNewUser(username, password);
    }

  }

  void _handleStorageNewUser(String username, String password) async {
    var jsonObject = {
      'username': username,
      'password' : password
    };
    print(jsonObject);
  }

  bool _checkIsSamePassword(String password, String retype){
    // Compare password and retype password
    if(password.compareTo(retype) == 0){
      return true;
    }
    return false;
  }

  void _cancel(){
    print("Cancel");
  }

  Widget _buttonForm(){
    return new Row(
      children: <Widget>[
        _button("OK", _finishSignIn),
        _button("Cancel",_cancel)
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