class User_Model{
  String username;
  String password;

  // contructor
  User_Model(
  this.username,
  this.password
  );

  User_Model.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'];

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'password': password,
      };
}