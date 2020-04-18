import 'package:cloud_firestore/cloud_firestore.dart';

class ParseUtil {
  static double tryParseDouble(dynamic value) {
    if (value is double) {
      return value;
    }
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  static int tryParseInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  static DateTime tryParseDateTime(Timestamp timestamp) {
    return timestamp != null ? timestamp.toDate() : null;
  }

  static Timestamp tryParseTimestamp(DateTime dateTime) {
    return dateTime != null ? Timestamp.fromDate(dateTime) : null;
  }
}