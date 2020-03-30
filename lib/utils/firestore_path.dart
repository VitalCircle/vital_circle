class FirestorePathSegment {
  static const String USERS = 'users';
  static const String LOCATIONS = 'locations';
  static const String HEALTH_RECORDS = 'healthRecords';
}

class FirestorePath {
  static String userPath(String userId) {
    return '${FirestorePathSegment.USERS}/$userId';
  }

  static String locationsPath(String userId) {
    return '${userPath(userId)}/${FirestorePathSegment.LOCATIONS}';
  }

  static String healthRecordsPath(String userId) {
    return '${userPath(userId)}/${FirestorePathSegment.HEALTH_RECORDS}';
  }
}
