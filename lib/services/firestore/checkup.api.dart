import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_circle/constants/log_zone.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/services/services.dart';
import 'package:vital_circle/utils/firestore_path.dart';

import '../../models/index.dart';

class CheckupApi {
  final _log = LogService.zone(LogZone.FIRESTORE);

  Stream<List<Checkup>> streamCheckups(String userId) {
    final path = FirestorePath.checkupsPath(userId);
    return Firestore.instance.collection(path).snapshots().map((query) {
      _log.debug('streamCheckups', <String, dynamic>{'userId': userId, 'count': query.documents.length});
      return query.documents
          .where((doc) => doc.data != null)
          .map((doc) => Checkup.fromFirestore(doc.documentID, doc.data))
          .toList();
    });
  }

  Future<Checkup> getCheckup(String userId, String checkupId) async {
    final path = FirestorePath.checkupPath(userId, checkupId);
    final doc = await Firestore.instance.document(path).get();
    if (!doc.exists) {
      return null;
    }
    final checkup = Checkup.fromFirestore(doc.documentID, doc.data);
    _log.debug('getCheckup', <String, dynamic>{'userId': userId, 'checkupId': checkupId, 'Checkup': doc.data});
    return checkup;
  }

  Future<List<Checkup>> getCheckupsForTimeRange(String userId, DateTime start, DateTime end) async {
    final path = FirestorePath.checkupsPath(userId);
    final query = await Firestore.instance
        .collection(path)
        .where(CheckupProperty.TIMESTAMP, isGreaterThanOrEqualTo: start, isLessThanOrEqualTo: end)
        .getDocuments();
    _log.debug('getCheckupsForTimeRange', <String, dynamic>{'userId': userId, 'count': query.documents.length});
    return query.documents
        .where((doc) => doc.data != null)
        .map((doc) => Checkup.fromFirestore(doc.documentID, doc.data))
        .toList();
  }

  String addCheckup(String userId, Checkup checkup) {
    final path = FirestorePath.checkupsPath(userId);
    final data = checkup.toFirestore();
    final doc = Firestore.instance.collection(path).document();
    doc.setData(data);
    _log.debug('addCheckup', <String, dynamic>{'userId': userId, 'data': data});
    return doc.documentID;
  }

  void updateCheckup(String userId, Checkup checkup) {
    final path = FirestorePath.checkupPath(userId, checkup.id);
    final data = checkup.toFirestore();
    final doc = Firestore.instance.document(path);
    doc.updateData(data);
    _log.debug('updateCheckup', <String, dynamic>{'userId': userId, 'data': data});
  }
}
