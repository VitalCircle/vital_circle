import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../services/services.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel.of(BuildContext context)
      : _authService = Provider.of(context),
        _checkupApi = Provider.of(context),
        _geoService = Provider.of(context);

  final AuthService _authService;
  final CheckupApi _checkupApi;
  final GeoService _geoService;

  StreamSubscription _dailyCheckupSubscription;

  bool _isReady = false;
  bool get isReady => _isReady;

  bool _hasCheckedInToday = false;
  bool get hasCheckedInToday => _hasCheckedInToday;

  Future onInit() async {
    _geoService.startPolling();
    await _subscribeToDailyCheckups();
  }

  Future _subscribeToDailyCheckups() async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(now.year, now.month, now.day, 23, 59, 59, 1000, 1000);
    final user = await _authService.user;
    _dailyCheckupSubscription = _checkupApi.streamCheckupsForTimeRange(user.uid, start, end).listen((checkups) {
      _hasCheckedInToday = checkups.isNotEmpty;
      _isReady = true;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _geoService.stopPolling();

    if (_dailyCheckupSubscription != null) {
      _dailyCheckupSubscription.cancel();
    }
    super.dispose();
  }
}
