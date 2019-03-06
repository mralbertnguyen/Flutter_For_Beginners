import 'dart:convert';

User_Model userFromJson(String str){
  final jsonData = json.decode(str);
  return User_Model.fromMap(jsonData);
}

String userToJson(User_Model user){
    final dataUser = user.toJson();
    return json.encode(dataUser);
}
class User_Model{
  String username;
  String password;

  // constructor
  User_Model({
    this.username,
    this.password
  });

  // decode
  factory User_Model.fromMap(Map<String, dynamic> json) => new User_Model(
    username: json["username"],
    password: json["[password"],
  );

  // Encode
  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'password': password,
      };
}