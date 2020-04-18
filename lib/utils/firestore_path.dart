class FirestorePathSegment {
  static const String USERS = 'users';
  static const String LOCATIONS = 'locations';
  static const String CHECKUPS = 'checkins';
}

class FirestorePath {
  static String userPath(String userId) {
    return '${FirestorePathSegment.USERS}/$userId';
  }

  static String locationsPath(String userId) {
    return '${userPath(userId)}/${FirestorePathSegment.LOCATIONS}';
  }

  static String checkinsPath(String userId) {
    return '${userPath(userId)}/${FirestorePathSegment.CHECKUPS}';
  }

  static String checkinPath(String userId, String checkinId) {
    return '${checkinsPath(userId)}/$checkinId';
  }
}
