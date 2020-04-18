import 'package:vital_circle/utils/parse_util.dart';

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
  static const ACCEPTED_LOCATION_SHARING = 'acceptedLocationSharing';
  static const LOCATION_SHARING_DATE = 'locationSharingDate';
  static const PRIVACY_POLICY_DATE = 'privacyPolicyDate';
  static const TERMS_OF_SERVICE_DATE = 'termsOfServiceDate';
}

class Agreements {
  Agreements(this.acceptedLocationSharing, this.locationSharing, this.privacyPolicy, this.termsOfService);

  Agreements.fromFirestore(Map<String, dynamic> agreements)
      : acceptedLocationSharing = agreements[AgreementsProperty.ACCEPTED_LOCATION_SHARING] ?? false,
        locationSharing = ParseUtil.tryParseDateTime(agreements[AgreementsProperty.LOCATION_SHARING_DATE]),
        privacyPolicy = ParseUtil.tryParseDateTime(agreements[AgreementsProperty.PRIVACY_POLICY_DATE]),
        termsOfService = ParseUtil.tryParseDateTime(agreements[AgreementsProperty.TERMS_OF_SERVICE_DATE]);

  bool acceptedLocationSharing;
  DateTime locationSharing;
  DateTime privacyPolicy;
  DateTime termsOfService;
}
