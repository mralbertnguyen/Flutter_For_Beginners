class User_Model{
  String username;
  String password;

  // contructor
  User_Model(
  this.username,
  this.password
  );

  // Encode
  User_Model.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'];


  String get _username => username;
  String get _password => password;

  // Decode
  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'password': password,
      };
}