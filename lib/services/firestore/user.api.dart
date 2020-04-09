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

  void updateUserLegalAgreements(String id) {
    final userPath = FirestorePath.userPath(id);
    final data = <String, dynamic>{
      UserProperty.AGREEMENTS: <String, dynamic>{
        AgreementsProperty.CONSENT: FieldValue.serverTimestamp(),
        AgreementsProperty.PRIVACY: FieldValue.serverTimestamp(),
        AgreementsProperty.TERMS_OF_SERVICE: FieldValue.serverTimestamp(),
      }
    };
    _log.debug(
        'updateUserLegalAgreements', <String, dynamic>{'id': id, 'data': data});
    Firestore.instance.document(userPath).setData(data, merge: true);
  }

  void updateUserLocationAgreement(String id) {
    final userPath = FirestorePath.userPath(id);
    final data = <String, dynamic>{
      UserProperty.AGREEMENTS: <String, dynamic>{
        AgreementsProperty.LOCATION_SHARING: FieldValue.serverTimestamp()
      }
    };
    _log.debug('updateUserLocationAgreement',
        <String, dynamic>{'id': id, 'data': data});
    Firestore.instance.document(userPath).setData(data, merge: true);
  }
}
