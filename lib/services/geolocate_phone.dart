import 'package:tuple/tuple.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';t
import 'models.location.dart'

final databaseReference = FirebaseDatabase.instance.reference();
var geolocator = Geolocator();
var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

StreamSubscription<Position> positionStream = geolocator.getPositionStream(locationOptions).listen(
    (Position position) {
        insertLocationRow(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
    });

// Insert into database
Future<bool> insertLocationRow(Position position) async {
    
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    
    if (myLocation != null)
        databaseReference.child("Locations").set({
            'latitude': position.latitude,
            'longitude': position.longitude
        });
    
    



