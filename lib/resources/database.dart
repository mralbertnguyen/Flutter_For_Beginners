import 'dart:io';
import 'dart:async';

import'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user_model.dart';

// Create private  constructor that can be used only inside the class
class DBProvider{
  // Constructor
  DBProvider._();
  // Create singleton
  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async{
    if(_database != null) return _database;

    // if _data base null we instantiate new database
    _database = await initDB();

    return _database;
  }

  static final String userTableName = "User";
  static final String dataTableName = "Data";

  static final String queryCreateDataTable =
      "CREATE TABLE $dataTableName ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "title VARCHAR(50),"
      "desc VARCHAR(255) "
      ")"
  ;

  static final String queryCreateUserTable  =
      "CREATE TABLE $userTableName ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "username VARCHAR(15),"
      "password VARCHAR(255) "
      ")"
  ;

  initDB() async{
    // get directory
    Directory directory = await getApplicationDocumentsDirectory();
    //Set db path file
    String path = join(directory.path , "Database.db");

    return await openDatabase(path, version: 1 ,onOpen: (db) {},
      onCreate: (Database db , int version) async {
        await db.execute(queryCreateUserTable);
      });
  }

  newUser(User_Model user) async{

    final String queryInsertNewUser = 'INSERT INTO  $userTableName ('
        'id, '
        'username, '
        'password)'
        ' VALUES (?,?,?) ';
    final db = await database;

     //Insert new user into table
      var insertNewUser = await db.rawInsert(
        queryInsertNewUser, [ user.username, user.password]
      );
    return insertNewUser;
  }

  Future<List<User_Model>> getAllUser() async{

    final db = await database;
    var res = await db.query(userTableName);

    List<User_Model> list = res.isNotEmpty ? res.map((c) => User_Model.fromMap(c)).toList() : [];

    return list;

  }

}




