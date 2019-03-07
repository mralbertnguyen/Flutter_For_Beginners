import 'dart:convert';

NoteModel itemFromJson(String str){
  final jsonData = json.decode(str);
  return NoteModel.fromMap(jsonData);
}

class NoteModel {
  int id;
  String title;
  String desc;

  NoteModel({
    this.id,
    this.title,
    this.desc
  });

  // Decode
  factory NoteModel.fromMap(Map<String, dynamic> json) => new NoteModel(
    id: json['id'],
    title: json['title'],
    desc: json['desc']
  );

  //Encode
  Map<String, dynamic> json() => {
    'title' : title,
    'desc' : desc
  };


}