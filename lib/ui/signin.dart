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
      body: Builder(
          builder: (context) =>
          new Column(
            children: <Widget>[
              _inputTextField("User name", usernameController, false),
              _inputTextField("Password", passwordController, true),
              _inputTextField("Retype password", retypePasswordController, true),
              _buttonForm(context),
            ],
          ),
      ),

    );
  }

  /*
  * Widgets
  * */
  Widget _buttonForm(BuildContext formContext){
    return new Row(
      children: <Widget>[
        _button("OK", finishSignIn ),
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
  finishSignIn(){
    // Get user name and password
    final String _username = usernameController.text;
    final String _password =  widgetController.WidgetAndFunctionState().generateMd5(passwordController.text);
    final String retype = widgetController.WidgetAndFunctionState().generateMd5(retypePasswordController.text);

    if(!_checkIsSamePassword(_password, retype)){
      print("Please check password again");
      widgetController.WidgetAndFunctionState().customDialog("Error","Please check password again",context);
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
    // Show snackbar
    // Back previous screen
    Navigator.of(context).pop();
    }else{
      widgetController.WidgetAndFunctionState().customDialog("Existed", "Existed",context);
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
    // Back previous screen
    Navigator.of(context).pop();
  }




}