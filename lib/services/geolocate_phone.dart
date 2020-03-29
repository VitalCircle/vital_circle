import 'package:tuple/tuple.dart';
import 'package:geolocator/geolocator.dart';

//TODO: F(x) that connects to the database and saves the coordinates


Tuple2<double, double> getPhoneLocation() {
  // Get current position of phone
  //Position myLocation = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //final coordinates = new Coordinates(myLocation.latitude, myLocation.longitude);
  //var currentAddress = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  
  // TODO: add lat and long
  return new Tuple2(lat, long);
}

