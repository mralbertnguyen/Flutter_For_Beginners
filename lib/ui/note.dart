import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../bloc/databaseBloc.dart';
import 'package:flutter_app/ui/widgetsAndFunction.dart' as widgetController;
import 'package:flutter/services.dart';

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
  final widgetPage = widgetController.WidgetAndFunctionState();

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

    super.initState();
  }

  @override
  void dispose() {
    bloc.dispone();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      // Float button avoid view
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Note"),
        backgroundColor: widgetPage.mainColor,
      ),
      body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            print("tap on gesture");
          },
          child: new Container(
            decoration: new BoxDecoration(
            ),

            child: new Theme(
              data: ThemeData(
                primaryColor: widgetPage.mainColor,
                primaryColorDark: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  new GestureDetector(
                    onTap: () {
                      print("Tap on gesture ");
                    },
                    child: noteForm(),
                  )
                ],
              ),
            ),
          )),

      floatingActionButton: Container(
        width: 200.0,
        height: 200.0,
        padding: EdgeInsets.only(bottom: 100.0),
        child: FloatingActionButton(
          child: Icon(
            Icons.done,
            size: 100,
          ),
          onPressed: saveNote,
          backgroundColor: widgetPage.mainColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /*
  *  Widgets
  * */
  Widget noteForm() {
    if (widget.note == null) {
      return Column(
        children: <Widget>[
          // Type title
          customTextFieldForNotePage(
              titleTxtController, TextInputType.text, 1, true, "Title", 50),
          // Type desc
          customTextFieldForNotePage(descTxtController, TextInputType.multiline,
              null, true, "Content", 200),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          // Type title
          customTextFieldForNotePage(
              titleTxtController, TextInputType.text, 1, true, "Title", 50),
          // Type desc
          customTextFieldForNotePage(descTxtController, TextInputType.multiline,
              null, true, "Content", 200),
        ],
      );
    }
  }

  Container customTextFieldForNotePage(
      TextEditingController _controller,
      TextInputType _keyboardType,
      int _maxLines,
      bool enabled,
      String label,
      double height) {
    return Container(
      decoration: new BoxDecoration(),
      width: 400,
      height: height,
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: TextField(
          decoration: InputDecoration(labelText: label),
          controller: _controller,
          keyboardType: _keyboardType,
          maxLines: _maxLines,
          enabled: enabled),
    );
  }

  Text titleWidget(String str) {
    return Text(
      str,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 40),
    );
  }

  bool checkNotNull(String title, String content) {
    if (title.length == 0 || content.length == 0) {
      return false;
    }
    return true;
  }

  void saveNote() {
    // Close keyboard
    FocusScope.of(context).requestFocus(new FocusNode());

    final String title = titleTxtController.text;
    final String desc = descTxtController.text;

    if (checkNotNull(title, desc)) {
      // Get id from note object existed
      if (widget.note != null) {
        print("Update note");
        final int id = widget.note.id;
        var updateNote = NoteModel(id: id, title: title, desc: desc);
        // Update note
        bloc.updateNote(updateNote);
      } else {
        print("Add note");
        var newNote = NoteModel(title: title, desc: desc);
        // Add new note
        bloc.addNote(newNote);
      }
      // back to main screen
      Navigator.of(context).pop();
    } else {
      print("Empty title | desciption");
    }
  }
}
