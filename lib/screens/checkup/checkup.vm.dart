import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vital_circle/constants/log_zone.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/services/services.dart';
import 'package:vital_circle/utils/firestore_path.dart';

class CheckupViewModel extends ChangeNotifier {
  CheckupViewModel.of(BuildContext context)
      : _authService = Provider.of(context);

  final AuthService _authService;
  final _log = LogService.zone(LogZone.CHECKUP);
  final checkup = Checkup.empty();
  FirebaseUser _user;

  void init() async {
    _user = await _authService.user;
  }

  void update() {
    notifyListeners();
  }

  void submit() {
    // TODO: this sloppy mess ignores all validation
    final userCheckupPath = FirestorePath.healthRecordsPath(_user.uid);
    final userCheckupRef = Firestore.instance.collection(userCheckupPath);
    final data = checkup.toFirestore();
    _log.debug('insertCheckup', data);
    userCheckupRef.add(data);
  }
}
