import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class MapBloc{

  // Create controller
  StreamController mapController = new StreamController();

  // Get Stream from Controller
  Stream get mapStream =>  mapController.stream;

  // Config google map variables
  Completer<GoogleMapController> mapCompleter = Completer();
  LatLng centerLatLong ;


  var location = new Location();
  LocationData locationData;
  var permissionLocation;


  getCurrentLocation () async{
    //Location object
    try {

      bool hasPer = await location.hasPermission();

      if(hasPer){
        locationData = await location.getLocation();
        centerLatLong = LatLng(locationData.latitude, locationData.longitude);
       }else{
        // Request permission
        location.requestPermission();
        print("Has not permission");
       }
    }catch (e) {
      locationData = null;
    }

  }


  onCreatedMap(GoogleMapController ggMapController) {
    mapCompleter.complete(ggMapController);
  }

  // Close Controller when app dispose
  dispose(){
    mapController.close();
  }


}