import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_circle/constants/log_zone.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/services/services.dart';
import 'package:vital_circle/utils/firestore_path.dart';

class CheckinApi {
  final _log = LogService.zone(LogZone.FIRESTORE);

  Stream<List<Checkin>> streamCheckins(String userId) {
    final path = FirestorePath.checkinsPath(userId);
    return Firestore.instance.collection(path).snapshots().map((query) {
      _log.debug('streamCheckins',
          <String, dynamic>{'userId': userId, 'count': query.documents.length});
      return query.documents
          .where((doc) => doc.data != null)
          .map((doc) => Checkin.fromFirestore(doc.documentID, doc.data))
          .toList();
    });
  }

  Stream<List<Checkin>> streamCheckinsForTimeRange(
      String userId, DateTime start, DateTime end) {
    final path = FirestorePath.checkinsPath(userId);
    return Firestore.instance
        .collection(path)
        .where(CheckinProperty.TIMESTAMP,
            isGreaterThanOrEqualTo: start, isLessThanOrEqualTo: end)
        .snapshots()
        .map((query) {
      _log.debug('streamCheckinsForTimeRange',
          <String, dynamic>{'userId': userId, 'count': query.documents.length});
      return query.documents
          .where((doc) => doc.data != null)
          .map((doc) => Checkin.fromFirestore(doc.documentID, doc.data))
          .toList();
    });
  }

  Future<Checkin> getCheckin(String userId, String checkinId) async {
    final path = FirestorePath.checkinPath(userId, checkinId);
    final doc = await Firestore.instance.document(path).get();
    if (!doc.exists) {
      return null;
    }
    final checkin = Checkin.fromFirestore(doc.documentID, doc.data);
    _log.debug('getCheckin', <String, dynamic>{
      'userId': userId,
      'checkinId': checkinId,
      'Checkin': doc.data
    });
    return checkin;
  }

  String addCheckin(String userId, Checkin checkin) {
    final path = FirestorePath.checkinsPath(userId);
    final data = checkin.toFirestore();
    final doc = Firestore.instance.collection(path).document();
    doc.setData(data);
    _log.debug('addCheckin', <String, dynamic>{'userId': userId, 'data': data});
    return doc.documentID;
  }

  void updateCheckin(String userId, Checkin checkin) {
    final path = FirestorePath.checkinPath(userId, checkin.id);
    final data = checkin.toFirestore();
    final doc = Firestore.instance.document(path);
    doc.updateData(data);
    _log.debug(
        'updateCheckin', <String, dynamic>{'userId': userId, 'data': data});
  }
}
