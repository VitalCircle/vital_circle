import 'package:vital_circle/utils/parse_util.dart';

class LocationProperty {
  static const LATITUDE = 'lat';
  static const LONGITUDE = 'long';
  static const TIMESTAMP = 'timestamp';
}

class Location {
  Location(this.id, this.lat, this.long, this.timestamp);

  Location.fromFirestore(this.id, Map<String, dynamic> location)
      : lat = ParseUtil.tryParseDouble(location[LocationProperty.LATITUDE]),
        long = ParseUtil.tryParseDouble(location[LocationProperty.LONGITUDE]),
        timestamp = ParseUtil.tryParseDateTime(location[LocationProperty.TIMESTAMP]);

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      LocationProperty.LATITUDE: lat,
      LocationProperty.LONGITUDE: long,
      LocationProperty.TIMESTAMP: ParseUtil.tryParseTimestamp(timestamp)
    };
  }

  String id;
  double lat;
  double long;
  DateTime timestamp;
}
