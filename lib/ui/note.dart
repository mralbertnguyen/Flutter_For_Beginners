import 'package:flutter/material.dart';

import '../resources/database.dart';
import '../models/note_model.dart';

import '../bloc/databaseBloc.dart';

void main() => runApp(Note());

class Note extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(theme: ThemeData(), home: new NotePage());
  }
}

class NotePage extends StatefulWidget {
  NotePage({Key key, @required this.note}) : super(key: key);

  final NoteModel note;

  @override
  NotePageState createState() => new NotePageState();
}

class NotePageState extends State<NotePage> {
  final bloc = NoteBloc();

  // controllers to handle text
  TextEditingController titleTxtController = TextEditingController();
  TextEditingController descTxtController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.note != null) {
      print("Init state");
      titleTxtController.text = widget.note.title;
      descTxtController.text = widget.note.desc;
    }
  }

  @override
  void dispose() {

    bloc.dispone();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Note"),
        actions: <Widget>[],
      ),
      body: new Column(
        children: <Widget>[
          titleWidget(),
          noteForm(),
        ],
      ),
    );
  }

  // Widgets
  Widget noteForm() {
    if (widget.note == null) {
      return new Column(
        children: <Widget>[
          new Text("Title: "),
          // Type title
          customTextField(titleTxtController, TextInputType.text, 1, true),
          new Text("Desciption: "),
          // Type desc
          customTextField(
              descTxtController, TextInputType.multiline, null, true),
          new RaisedButton(onPressed: saveNote)
        ],
      );
    } else {
      return new Column(
        children: <Widget>[
          new Text("Title: "),
          // Type title
          customTextField(titleTxtController, TextInputType.text, 1, true),
          new Text("Desciption: "),
          // Type desc
          customTextField(
              descTxtController, TextInputType.multiline, null, true),
          new RaisedButton(onPressed: saveNote)
        ],
      );
    }
  }

  TextField customTextField(TextEditingController _controller,
    TextInputType _keyboardType, int _maxLines, bool enabled) {
    return TextField(
        controller: _controller,
        keyboardType: _keyboardType,
        maxLines: _maxLines,
        enabled: enabled);
  }

  Text titleWidget() {
    return Text("Note");
  }

  void saveNote() {
    final String title = titleTxtController.text;
    final String desc = descTxtController.text;

    // Get id from note object existed
    if(widget.note != null){
      print("Update note");
      final int id = widget.note.id;
      var updateNote = NoteModel(id: id, title: title, desc: desc);
      // Update note
      bloc.updateNote(updateNote);
    }else{
      print("Add note");
      var newNote = NoteModel(title: title, desc: desc);
      // Add new note
      bloc.addNote(newNote);
    }

  }
}
