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

  bool _isReady = false;
  bool get isReady => _isReady;

  bool _hasCheckedInToday = false;
  bool get hasCheckedInToday => _hasCheckedInToday;

  Future onInit() async {
    _geoService.startPolling();
    _hasCheckedInToday = await _hasCheckupForToday();
    _isReady = true;
    notifyListeners();
  }

  Future<bool> _hasCheckupForToday() async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(now.year, now.month, now.day, 23, 59, 59, 1000, 1000);
    final user = await _authService.user;
    final checkups = await _checkupApi.getCheckupsForTimeRange(user.uid, start, end);
    return checkups.isNotEmpty;
  }

  @override
  void dispose() {
    _geoService.stopPolling();
    super.dispose();
  }
}
