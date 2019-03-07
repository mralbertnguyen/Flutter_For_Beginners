import 'dart:convert';

UserModel userFromJson(String str){
  final jsonData = json.decode(str);
  return UserModel.fromMap(jsonData);
}

String userToJson(UserModel user){
    final dataUser = user.toJson();
    return json.encode(dataUser);
}
class UserModel{
  String username;
  String password;

  // constructor
  UserModel({
    this.username,
    this.password
  });

  // decode
  factory UserModel.fromMap(Map<String, dynamic> json) => new UserModel(
    username: json["username"],
    password: json["password"],
  );

  // Encode
  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'password': password,
      };
}