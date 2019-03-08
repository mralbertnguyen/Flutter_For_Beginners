import 'package:flutter/material.dart';
import 'package:flutter_app/ui/home.dart';
import 'package:flutter_app/ui/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../resources/database.dart';
import '../models/user_model.dart';
import '../resources/widgetsAndFunction.dart' as widgetController;
import 'dart:async';

void main() => runApp(Login());

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

  final widgetPage = widgetController.WidgetAndFunctionState();

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
  void initState() {
    // TODO: implement initState
    checkIsLogin();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
          title: new Text("Login"),
          backgroundColor: widgetPage.mainColor,
        ),
        body: new Center(
            child: new Theme(
              data: new ThemeData(
                primaryColor: widgetPage.mainColor,
                primaryColorDark: Colors.white,
              ),
              child: new Column(
                children: <Widget>[
                  widgetPage.customTitleAsLogo("NOTE"),
                  widgetPage.inputTextField("User name", userNameController, false),
                  widgetPage.inputTextField("Password: ", passwordController, true),
                  buttonForm()
                ],
              ),
            )
        )
    );
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
    final String _password = widgetController.WidgetAndFunctionState()
        .generateMd5(passwordController.text);
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
            widgetController.WidgetAndFunctionState().customDialog(
                "Error", "Check username and password again!", context);
          }
        } else {
          widgetController.WidgetAndFunctionState().customDialog(
              "Error", "Check username and password again!", context);
        }
      } else {
        widgetController.WidgetAndFunctionState()
            .customDialog("Error", "User not exist!", context);
      }
    } else {
      widgetController.WidgetAndFunctionState()
          .customDialog("Error", "Please type username and password", context);
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



  Container buttonForm() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          widgetPage.button("Log in", checkInfoLogin),
          widgetPage.button("Sign up", signInNewAccount)
        ],
      ),
    );
  }


}
