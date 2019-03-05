import 'package:flutter/material.dart';
import 'package:flutter_app/ui/home.dart';
import 'package:flutter_app/ui/signin.dart';

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
  void _checkInfoLogin(){
    final String _username = userNameController.text;
    final String _password = passwordController.text;

    // If user name not null and correct with account default then accept login
    if(!_checkNull(_username, _password)){
      if(_checkIsCorrect(_username, _password)){
        _loginSucess();
      }
    }else {
      print("Please check user name, password again");
    }
  }

  bool _checkNull (String username, String password){
    if(username.isEmpty && password.isEmpty){
      return true;
    }else{
      return false;
    }
  }

  bool _checkIsCorrect(String username, String password){
    if(username.compareTo(userNameDefault) != 0 && password.compareTo(passwordDefault) != 0){
      return false;
    }else{
      return true;
    }
  }

  void _loginSucess(){
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
        _button("Log in", _checkInfoLogin),
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

