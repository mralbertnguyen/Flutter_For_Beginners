import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/ui/note_app/login.dart';
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


}