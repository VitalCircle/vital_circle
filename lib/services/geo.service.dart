import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:vital_circle/constants/log_zone.dart';
import 'package:vital_circle/models/location.model.dart';
import 'package:vital_circle/services/log/index.dart';
import 'package:vital_circle/services/services.dart';
import 'package:vital_circle/utils/firestore_path.dart';

class GeoService {
  GeoService(this._authService);

  final AuthService _authService;
  final _log = LogService.zone(LogZone.GEO);
  final _geolocator = Geolocator();
  final _locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
  StreamSubscription<Position> _sub;

  Future<void> startPolling() async {
    final permission = await LocationPermissions().checkPermissionStatus();
    if (permission != PermissionStatus.granted) {
      return;
    }
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
