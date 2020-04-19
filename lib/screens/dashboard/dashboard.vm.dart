import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../services/services.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel.of(BuildContext context)
      : _authService = Provider.of(context),
        _checkinApi = Provider.of(context),
        _geoService = Provider.of(context);

  final AuthService _authService;
  final CheckinApi _checkinApi;
  final GeoService _geoService;

  StreamSubscription _dailyCheckinSubscription;

  bool _isReady = false;
  bool get isReady => _isReady;

  bool _hasCheckedInToday = false;
  bool get hasCheckedInToday => _hasCheckedInToday;

  Future onInit() async {
    _geoService.startPolling();
    await _subscribeToDailyCheckins();
  }

  Future _subscribeToDailyCheckins() async {
    final now = DateTime.now();
    // TODO: stream date and time to handle crossing into mid-night
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(now.year, now.month, now.day, 23, 59, 59, 1000, 1000);
    final user = await _authService.user;
    _dailyCheckinSubscription = _checkinApi.streamCheckinsForTimeRange(user.uid, start, end).listen((checkins) {
      _hasCheckedInToday = checkins.isNotEmpty;
      _isReady = true;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _geoService.stopPolling();

    if (_dailyCheckinSubscription != null) {
      _dailyCheckinSubscription.cancel();
    }
    super.dispose();
  }
}
