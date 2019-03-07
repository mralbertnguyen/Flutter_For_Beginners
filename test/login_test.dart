
import 'package:path_provider/path_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app/ui/login.dart';
import 'package:flutter_app/models/user_model.dart';
import 'dart:async';
void main(){

  /*
  *
  * Test Login's functions
  *
  * */

  test('Check password and retype password',(){
    var result = LoginPageState().checkIsCorrect('Password', 'pwd');
    expect(result, false);
  });

  test('Check password and retype password',(){
    var result = LoginPageState().checkIsCorrect('password', 'password');
    expect(result, true);
  });

  test('Check user existed on database',() async {
    UserModel model = new UserModel(username:"ddasda",password: "sdadwa" );
    var result = await LoginPageState().checkIsExisted('Admin');
    if(model.username.compareTo(result.username) != 0){
      expect(result, false);
    }else if(model.username.compareTo(result.username) == 0){
      expect(result, true);
    }
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {

  });


}