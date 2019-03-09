import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_model.dart';
import '../resources/database.dart';
import '../bloc/databaseBloc.dart';
import'package:flutter_app/ui/widgetsAndFunction.dart' as widgetController;

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
  final widgetPage = widgetController.WidgetAndFunctionState();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      appBar: AppBar(
        title:  Text("Sign in"),
        backgroundColor: widgetPage.mainColor,
      ),
        body:  Center(
            child:  Theme(
              data:  ThemeData(
                primaryColor: widgetPage.mainColor,
                primaryColorDark: Colors.white,
              ),
              child:  Column(
                children: <Widget>[
                  widgetPage.inputTextField("User name", usernameController, false),
                  widgetPage.inputTextField("Password", passwordController, true),
                  widgetPage.inputTextField("Retype password", retypePasswordController, true),
                  buttonForm(context),
                ],
              ),
            )
        )
    );
  }
  /*
  * Widgets
  * */
  Widget buttonForm(BuildContext formContext){
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          widgetPage.button("Sign In", finishSignIn),
          widgetPage.button("Cancel", cancel)
        ],
      ),
    );
  }

  /*
  * Functions to handle business
  * */
  finishSignIn(){
    // Close keyboard
    FocusScope.of(context).requestFocus(new FocusNode());
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

  void cancel(){
    // Close keyboard
    FocusScope.of(context).requestFocus(new FocusNode());
    print("Cancel");
    // Back previous screen
    Navigator.of(context).pop();
  }

}