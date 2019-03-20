import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapBloc{

  // Create controller
  StreamController mapController = new StreamController();

  // Get Stream from Controller
  Stream get mapStream =>  mapController.stream;

  // Config google map variables
  Completer<GoogleMapController> mapCompleter = Completer();
  LatLng centerLatLong = LatLng(45.521563, -122.677433);

  //
  onCreatedMap(GoogleMapController ggMapController) {
    mapCompleter.complete(ggMapController);
  }

  // Close Controller when app dispose
  dispose(){
    mapController.close();
  }


}