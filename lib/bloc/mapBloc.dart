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
  LatLng centerLatLong = LatLng(10.823099, 106.629662);


  var location = new Location();
  LocationData locationData;
  var permissionLocation;

  LatLng lastLocation = LatLng(10.22222, 101.2212);

  firstSetupMap() async {
    try {
      bool hasPer = await location.hasPermission();
      if(hasPer){

      }else{
        // Request permission
        await location.requestPermission();
        print("Has not permission");
      }
    }catch (e) {
      print("ERROR");
    }
  }

  getCurrentLocation () async{
    //Location object
    try {
      bool hasPer = await location.hasPermission();
      print(hasPer);
        if(hasPer){
        locationData = await location.getLocation();
        centerLatLong = LatLng(locationData.latitude, locationData.longitude);
        lastLocation = LatLng(locationData.latitude, locationData.longitude);
        location.onLocationChanged().listen((data)=>{
        lastLocation = LatLng(data.latitude, data.longitude)
        });

       }else{
        // Request permission
          await location.requestPermission();
        print("Has not permission");
       }
    }catch (e) {
      locationData = null;
      print("ERROR");
    }

  }

  moveCamera(CameraPosition position){
    lastLocation = position.target;
  }
  onCreatedMap(GoogleMapController ggMapController) {
    mapCompleter.complete(ggMapController);
  }

  // Close Controller when app dispose
  dispose(){
    mapController.close();
  }


}