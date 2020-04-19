import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vital_circle/models/index.dart';

import '../../services/services.dart';

class CheckinHistoryViewModel extends ChangeNotifier {
  CheckinHistoryViewModel.of(BuildContext context)
      : _authService = Provider.of(context),
        _checkinApi = Provider.of(context);

  final AuthService _authService;
  final CheckinApi _checkinApi;

  StreamSubscription _checkinSub;

  bool _isReady = false;
  bool get isReady => _isReady;

  List<Checkin> _checkins;
  List<Checkin> get checkins => _checkins;

  Future onInit() async {
    final user = await _authService.user;
    _checkinSub = _checkinApi.streamCheckins(user.uid).where((x) => x != null).listen((checkins) {
      _isReady = true;
      _checkins = checkins;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    if (_checkinSub != null) {
      _checkinSub.cancel();
    }
    super.dispose();
  }
}
