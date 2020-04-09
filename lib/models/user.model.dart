import 'package:cloud_firestore/cloud_firestore.dart';

class UserProperty {
  static const AGREEMENTS = 'agreements';
}

class User {
  User(this.id);

  User.fromFirestore(this.id, Map<String, dynamic> user)
      : agreements = Agreements.fromFirestore(user[UserProperty.AGREEMENTS]);

  String id;
  Agreements agreements;
}

class AgreementsProperty {
  static const CONSENT = 'consent';
  static const LOCATION_SHARING = 'locationSharing';
  static const PRIVACY = 'privacy';
  static const TERMS_OF_SERVICE = 'termsOfService';
}

class Agreements {
  Agreements(this.consent, this.locationSharing, this.privacy, this.termsOfService);

  Agreements.fromFirestore(Map<String, dynamic> agreements)
      : consent = _toDateTime(agreements[AgreementsProperty.CONSENT]),
        locationSharing = _toDateTime(agreements[AgreementsProperty.LOCATION_SHARING]),
        privacy = _toDateTime(agreements[AgreementsProperty.PRIVACY]),
        termsOfService = _toDateTime(agreements[AgreementsProperty.TERMS_OF_SERVICE]);

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      UserProperty.AGREEMENTS: <String, dynamic>{
        AgreementsProperty.CONSENT: _fromDateTime(consent),
        AgreementsProperty.LOCATION_SHARING: _fromDateTime(locationSharing),
        AgreementsProperty.PRIVACY: _fromDateTime(privacy),
        AgreementsProperty.TERMS_OF_SERVICE: _fromDateTime(termsOfService)
      }
    };
  }

  static DateTime _toDateTime(Timestamp timestamp) {
    return timestamp != null ? timestamp.toDate() : null;
  }

  static Timestamp _fromDateTime(DateTime dateTime) {
    return dateTime != null ? Timestamp.fromDate(dateTime) : null;
  }

  DateTime consent;
  DateTime locationSharing;
  DateTime privacy;
  DateTime termsOfService;
}
