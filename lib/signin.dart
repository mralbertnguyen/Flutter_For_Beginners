import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
          _inputTextField("User name", usernameController),
          _inputTextField("Password", passwordController),
          _inputTextField("Retype password", retypePasswordController),
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
    }


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

  TextField _inputTextField(String placholder, TextEditingController controller){
    return TextField(
      textAlign: TextAlign.left,
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