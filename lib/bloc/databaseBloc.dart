import 'dart:async';

import '../models/note_model.dart';
import '../resources/database.dart';

class NoteBloc{
  final _noteController = StreamController<List<NoteModel>>.broadcast();

  get notes => _noteController.stream;

  dispone(){
    _noteController.close();
  }

  getNotes() async{
    _noteController.sink.add(await DBProvider.db.getAllNote());
  }

  NotesBloc(){
  }

  deleteNote(int id){
    DBProvider.db.deleteNote(id);
  }

  addNote(NoteModel note){
    DBProvider.db.newNote(note);
  }

  updateNote(NoteModel note){
    DBProvider.db.editNote(note);
  }
}