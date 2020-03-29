class FirestorePathSegment {
  static const String USERS = 'users';
  static const String LOCATIONS = 'locations';
}

class FirestorePath {
  static String userPath(String userId) {
    return '${FirestorePathSegment.USERS}/$userId';
  }

  static String locationsPath(String userId) {
    return '${userPath(userId)}/${FirestorePathSegment.LOCATIONS}';
  }
}
