class FirestorePathSegment {
  static const String USERS = 'users';
  static const String LOCATIONS = 'locations';
  static const String CHECKUPS = 'checkups';
}

class FirestorePath {
  static String userPath(String userId) {
    return '${FirestorePathSegment.USERS}/$userId';
  }

  static String locationsPath(String userId) {
    return '${userPath(userId)}/${FirestorePathSegment.LOCATIONS}';
  }

  static String checkupsPath(String userId) {
    return '${userPath(userId)}/${FirestorePathSegment.CHECKUPS}';
  }

  static String checkupPath(String userId, String checkupId) {
    return '${checkupsPath(userId)}/$checkupId';
  }
}
