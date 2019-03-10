import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../bloc/databaseBloc.dart';
import '../ui/note.dart';
import 'package:flutter_app/ui/widgetsAndFunction.dart' as widgetController;

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  final bloc = NoteBloc();
  final widgetPage = widgetController.WidgetAndFunctionState();
  @override
  void dispose() {
    // TODO: implement dispose
    bloc.dispone();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bloc.getNotes();
    return Scaffold(
      appBar: AppBar(
        title: Text("Note"),
        backgroundColor: widgetPage.mainColor,
      ),
      body: Theme(
        data: ThemeData(
          primaryColor: widgetPage.mainColor,
          primaryColorDark: Colors.white,
        ),
        child: StreamBuilder<List<NoteModel>>(
          stream: bloc.notes,
          builder:
              (BuildContext context, AsyncSnapshot<List<NoteModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  NoteModel note = snapshot.data[index];
                  final title = note.title;
                  return Dismissible(
                      key: UniqueKey(),
//                        secondaryBackground: Text("Delete"),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          // notify bottom with snackbar
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("Deleted $title note")));
                          // swipe left to right
                          bloc.deleteNote(note.id);
                        } else if (direction == DismissDirection.startToEnd) {
                          tapOnItemNote(note);
                        }
                      },
                      child: _itemList(note));
                },
              );
            } else {
              return Center(
                child: Text("No note"),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewNote,
        backgroundColor: widgetPage.mainColor,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Card _itemList(NoteModel note) {
    return Card(
        elevation: 0.8,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: makeListTitle(note),
        ));
  }

  ListTile makeListTitle(NoteModel note) {
    return ListTile(
      // Padding
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: customItemText(note.title, 25.0, 2),
      subtitle: customItemText(note.desc, 14.0, 4),
    );
  }

  Text customItemText(String txt, double size, int maxlines) {
    return Text(
      txt,
      maxLines: maxlines,
      style: TextStyle(
        color: widgetPage.whiteColor,
        fontSize: size,
      ),
    );
  }

  // Functions
  addNewNote() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotePage(note: null)),
    );
  }

  tapOnItemNote(NoteModel note) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotePage(note: note)),
    );
  }
}
