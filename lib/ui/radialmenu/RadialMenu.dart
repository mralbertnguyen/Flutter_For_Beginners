import 'package:flutter/material.dart';
import 'package:flutter_radial_menu/flutter_radial_menu.dart';

class RadialMenuStateless extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RadialMenuStateful();
  }
}

class RadialMenuStateful extends StatefulWidget {
  RadialMenuStateful({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  RadialMenuState createState() => new RadialMenuState(this.size);
}

enum MenuOptions {
  opendoor,
}

class RadialMenuState extends State<RadialMenuStateful> {
  final Size size;

  RadialMenuState(this.size);

  /// Config Radial Menu
  // Menu key
  GlobalKey<RadialMenuState> _radialMenuKey = new GlobalKey<RadialMenuState>();

  // Item list
  final List<RadialMenuItem<MenuOptions>> items = <RadialMenuItem<MenuOptions>>[
    new RadialMenuItem<MenuOptions>(
      value: MenuOptions.opendoor,
      child: new Icon(Icons.lock_open),
      iconColor: Colors.white,
      backgroundColor: Colors.blue[400],
      tooltip: 'unread',
    ),
  ];

  // void
  void _onItemSelected(MenuOptions value) {
    print(value);
  } 
  /// End config radial menu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Radial menu"),
      ),
        body: Center(
      child: new RadialMenu(
        progressAnimationDuration: Duration(
          milliseconds: 100
        ),
        key: _radialMenuKey,
        items: items,
        radius: 100.0,
        onSelected: _onItemSelected,
      ),
    ));
  }
}
