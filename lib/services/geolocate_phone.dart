import 'package:tuple/tuple.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';t
import 'models.location.dart'

final databaseReference = FirebaseDatabase.instance.reference();

// Insert into database
Future<bool> insertLocationRow(Location location) async {
    
    Position myLocation = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(myLocation.latitude, myLocation.longitude);
    
    databaseReference.child("Locations").set({
        'latitude': myLocation.latitude,
        'longitude': myLocation.longitude
    });
    