import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

void main() => runApp(Map());

class Map extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
        home : new Scaffold(
          appBar: new AppBar(
            title: new Text("Maps"),
          ),
          body: new MapPage(),
        )
    );
  }
}


class MapPage extends StatefulWidget{
  MapPage({Key key}) : super(key: key);

  @override
  MapPageState createState() => new MapPageState();

}

class MapPageState extends State<MapPage>{

  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _maps() ;
  }

  Widget _maps(){
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
    );
  }
}

