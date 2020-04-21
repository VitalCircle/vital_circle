import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_circle/constants/log_zone.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/services/services.dart';
import 'package:vital_circle/utils/firestore_path.dart';

class UserApi {
  final _log = LogService.zone(LogZone.FIRESTORE);

  Stream<User> streamUser(String id) {
    final userPath = FirestorePath.userPath(id);
    return Firestore.instance
        .document(userPath)
        .snapshots()
        .where((snapshot) => snapshot != null)
        .map((snapshot) {
      _log.debug(
          'streamLocation', <String, dynamic>{'path': snapshot.reference.path});
      return snapshot.data != null
          ? User.fromFirestore(snapshot.documentID, snapshot.data)
          : null;
    });
  }

  Future<User> getUser(String id) async {
    final userPath = FirestorePath.userPath(id);
    final doc = await Firestore.instance.document(userPath).get();
    if (!doc.exists) {
      return null;
    }
    final user = User.fromFirestore(doc.documentID, doc.data);
    _log.debug('getUser', <String, dynamic>{'id': id, 'user': doc.data});
    return user;
  }

  Future<void> updatePrivacyAgreement(String id) =>
      _updateAgreement(id, AgreementsProperty.PRIVACY_POLICY_DATE);
  Future<void> updateTermsOfServiceAgreement(String id) =>
      _updateAgreement(id, AgreementsProperty.TERMS_OF_SERVICE_DATE);

  Future<void> _updateAgreement(String id, String agreementKey) async {
    final userPath = FirestorePath.userPath(id);
    final data = <String, dynamic>{
      UserProperty.AGREEMENTS: <String, dynamic>{
        agreementKey: FieldValue.serverTimestamp()
      }
    };
    _log.debug('updateAgreement', <String, dynamic>{'id': id, 'data': data});
    await Firestore.instance.document(userPath).setData(data, merge: true);
  }

  Future<void> updateLocationSharingAgreement(String id, bool didAccept) async {
    final userPath = FirestorePath.userPath(id);
    final data = <String, dynamic>{
      UserProperty.AGREEMENTS: <String, dynamic>{
        AgreementsProperty.ACCEPTED_LOCATION_SHARING: didAccept,
        AgreementsProperty.LOCATION_SHARING_DATE: FieldValue.serverTimestamp()
      }
    };
    _log.debug('updateLocationSharingAgreement',
        <String, dynamic>{'id': id, 'data': data});
    await Firestore.instance.document(userPath).setData(data, merge: true);
  }
}
