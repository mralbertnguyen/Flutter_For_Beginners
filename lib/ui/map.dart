import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import '../bloc/mapBloc.dart';


void main() => runApp(Map());


class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
        home: new Scaffold(
      appBar: new AppBar(
        title: new Text("Maps"),
      ),
      body: new MapPage(),
    ));
  }
}

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  MapPageState createState() => new MapPageState();
}

class MapPageState extends State<MapPage> {
  MapBloc mapBloc = new MapBloc();

  @override
  Widget build(BuildContext context) {
    // Get current location when open app
    mapBloc.getCurrentLocation();
    // TODO: implement build
    return Stack(
      children: <Widget>[
        _maps(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: FloatingActionButton(onPressed: ()=>{mapBloc.getCurrentLocation()}),
        )
      ],
    );
  }

  Widget _maps() {
    return
      StreamBuilder(
          stream: mapBloc.mapStream,
          builder: (context, snapshot) => GoogleMap(
            onMapCreated: mapBloc.onCreatedMap,
            initialCameraPosition: CameraPosition(
              target: mapBloc.centerLatLong,
              zoom: 11.0,
            ),
          )
      );

  }
}
