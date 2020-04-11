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
        timestamp = _toDateTime(location[LocationProperty.TIMESTAMP]);

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      LocationProperty.LATITUDE: lat,
      LocationProperty.LONGITUDE: long,
      LocationProperty.TIMESTAMP: _fromDateTime(timestamp)
    };
  }

  static DateTime _toDateTime(Timestamp timestamp) {
    return timestamp != null ? timestamp.toDate() : null;
  }

  static Timestamp _fromDateTime(DateTime dateTime) {
    return dateTime != null ? Timestamp.fromDate(dateTime) : null;
  }

  String id;
  double lat;
  double long;
  DateTime timestamp;
}
