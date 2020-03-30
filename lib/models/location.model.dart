import 'package:cloud_firestore/cloud_firestore.dart';

class LocationProperty {
  static const LATITUDE = 'lat';
  static const LONGITUDE = 'long';
  static const TIMESTAMP = 'timestamp';
}

class Location {
  Location(this.id, this.lat, this.long, this.timestamp);

  Location.fromFirestore(this.id, Map<String, dynamic> location)
      : lat = double.tryParse(location[LocationProperty.LATITUDE]),
        long = double.tryParse(location[LocationProperty.LONGITUDE]),
        timestamp = (location[LocationProperty.TIMESTAMP] as Timestamp).toDate();

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      LocationProperty.LATITUDE: lat,
      LocationProperty.LONGITUDE: long,
      LocationProperty.TIMESTAMP: Timestamp.fromDate(timestamp)
    };
  }

  String id;
  double lat;
  double long;
  DateTime timestamp;
}
