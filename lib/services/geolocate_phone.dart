import 'package:tuple/tuple.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';t
import 'models.location.dart'

final databaseReference = FirebaseDatabase.instance.reference();

// Insert into database
Future<bool> insertLocationRow(Location location) async {
    
    Position myLocation = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(myLocation.latitude, myLocation.longitude);
    
    await _database
        .reference()
        .child("Locations")
        .child(Location.location)
        .set(<String, Object>{
            "latitude": Location.latitude,
            "longitude": Location.longitude
        }).then((onValue) {
            return true;
        }).catchError((onError) {
            return false;
        });
        
