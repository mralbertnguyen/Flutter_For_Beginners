import 'dart:async';

class MapBloc{

//   Create controller
  StreamController mapController = new StreamController();

  // Get Stream from Controller
  Stream get mapStream =>  mapController.stream;


  // Close Controller when app dispose
  dispose(){
    mapController.close();
  }


}