import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_model.dart';


import '../resources/database.dart';
import '../bloc/databaseBloc.dart';

import'../resources/widgetsAndFunction.dart' as widgetController;

class SignIn extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SignInPage();
  }
}

class SignInPage extends StatefulWidget{
  SignInPage({Key key}) : super(key: key);
  @override
  SignInPageSate createState() => new SignInPageSate();
}

class SignInPageSate extends State<SignInPage>{

  // Controllers for handle Text field
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController retypePasswordController = new TextEditingController();

  // Create bloc controller
  final bloc = UserBloc();


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

  /*
  * Widgets
  * */
  Widget _buttonForm(){
    return new Row(
      children: <Widget>[
        _button("OK", _finishSignIn),
        _button("Cancel",_cancel)
      ],
    );
  }

  TextField _inputTextField(String placeholder, TextEditingController controller, bool obscureText){
    return TextField(
      textAlign: TextAlign.left,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: placeholder,
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

  /*
  * Functions to handle business
  * */
  void _finishSignIn(){
    // Get user name and password
    final String _username = usernameController.text;
    final String _password =  widgetController.WidgetAndFunctionState().generateMd5(passwordController.text);
    final String retype = widgetController.WidgetAndFunctionState().generateMd5(retypePasswordController.text);

    if(!_checkIsSamePassword(_password, retype)){
      print("Please check password again");
      _showDialog("Error","Please check password again");
    }else{
      _handleStorageNewUser(_username, _password);
    }

  }

  void _handleStorageNewUser(String username, String password) async {
    // Cast data
    var object = UserModel(username: username, password: password);

    // It return a result if find object have same username
    // null if can't find
    var userExist = await DBProvider.db.getUser(username);

    if(userExist == null){
//      await DBProvider.db.newUser(object);
    bloc.addUser(object);

      // Return index of object
      // If is int parameter => created new user

    }else{
      _showDialog("Existed", "Existed");
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
    Navigator.of(context).pop();
  }

  void _showDialog(String title, String content){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions: <Widget>[
              new FlatButton(onPressed: (){
                Navigator.of(context).pop();
              },
                  child: new Text("Close"))
            ],
          );
        }
    );
  }


}