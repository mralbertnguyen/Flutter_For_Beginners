import 'dart:io';
import 'dart:async';

import'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user_model.dart';
import '../models/note_model.dart';

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
  static final String noteTableName = "Note";

  static final String queryCreateNoteTable =
      "CREATE TABLE $noteTableName ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "title VARCHAR(50), "
      "desc VARCHAR(255) "
      ")"
  ;

  static final String queryCreateUserTable  =
      "CREATE TABLE $userTableName ( "
      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "username VARCHAR(15), "
      "password VARCHAR(255) "
      ")"
  ;

  initDB() async{
    // get directory
    Directory directory = await getApplicationDocumentsDirectory();
    //Set db path file
    String path = join(directory.path , "Database.db");

    // open the database
    Database creatingDatabase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(queryCreateUserTable);
          await db.execute(queryCreateNoteTable);
        });

    return creatingDatabase;
  }

  newUser(UserModel user) async{
    final String queryInsertNewUser = 'INSERT INTO  $userTableName ('
        'username, '
        'password)'
        ' VALUES (?,?) ';
    final db = await database;
     //Insert new user into table
      var insertNewUser = await db.rawInsert(
        queryInsertNewUser, [user.username, user.password]
      );

    return insertNewUser;
  }

  Future<List<UserModel>> getAllUser() async{

    final db = await database;
    var res = await db.query(userTableName);

    List<UserModel> userList = res.isNotEmpty ? res.map((c) => UserModel.fromMap(c)).toList() : [];
    // index
    return userList;

  }

  getUser(String username) async{
    final db = await database;

    var res = await db.query(userTableName,where: "username = ?", whereArgs: [username]);

    return res.isNotEmpty ? UserModel.fromMap(res.first) : null;
  }

  /*
  * NOTE
  * */
  newNote(NoteModel note) async {
    final String queryInsertNewNote = 'INSERT INTO $noteTableName ('
        'title, '
        'desc )'
        ' VALUES (?,?) ';

    final db = await database;

    var insertNewItem = await db.rawInsert(
        queryInsertNewNote,[note.title, note.desc]
    );
    // index
    return insertNewItem;
  }


  Future<List<NoteModel>> getAllNote() async{
    final db = await database;
    var res = await db.query(noteTableName);
    List<NoteModel> noteList = res.isNotEmpty ? res.map((c) => NoteModel.fromMap(c)).toList() : [];
    return noteList;
  }

  getNote(int id) async{
      final db = await database;
      var res = await db.query(noteTableName, where: "id = ? ", whereArgs: [id]);

      return res.isNotEmpty ? NoteModel.fromMap(res.first) : null;
  }

  editNote(NoteModel note) async {
    final db = await database;
    final int id = note.id;
    var res = db.update(noteTableName, note.json(),where: "id = ?", whereArgs: [id]);
    return res;
  }

  deleteNote(int id) async {
    print("ID: " + id.toString());
    final db = await database;
    var result =db.delete(noteTableName, where: "id = ?", whereArgs: [id]);
    print(result);
    return result;
  }

}




