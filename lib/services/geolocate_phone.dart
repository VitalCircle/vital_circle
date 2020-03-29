import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:teamtemp/constants/log_zone.dart';
import 'package:teamtemp/models/location.model.dart';
import 'package:teamtemp/services/log/index.dart';
import 'package:teamtemp/services/services.dart';
import 'package:teamtemp/utils/firestore_path.dart';

class GeoService {
  GeoService(this._authService);

  final AuthService _authService;
  final _log = LogService.zone(LogZone.GEO);
  final _geolocator = Geolocator();
  final _locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
  StreamSubscription<Position> _sub;

  Future<void> startPolling() async {
    _log.trace('Start polling geo location.');
    final user = await _authService.user;
    _sub = _geolocator.getPositionStream(_locationOptions).listen((Position position) {
      _insertPosition(position, user.uid);
    });
  }

  void _insertPosition(Position position, String userId) {
    final location = Location(null, position.latitude, position.longitude, position.timestamp);
    final userLocPath = FirestorePath.locationsPath(userId);
    final userLocRef = Firestore.instance.collection(userLocPath);
    final data = location.toFirestore();
    _log.debug('insertPosition', data);
    userLocRef.add(data);
  }

  void stopPolling() {
    _log.trace('Stop polling geo location.');
    if (_sub != null) {
      _sub.cancel();
    }
  }
}

/*
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
*/
