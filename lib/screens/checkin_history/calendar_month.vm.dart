import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vital_circle/models/index.dart';

import '../../services/services.dart';

class CalendarMonthViewModel extends ChangeNotifier {
  CalendarMonthViewModel.of(BuildContext context)
      : _authService = Provider.of(context),
        _checkinApi = Provider.of(context);

  final AuthService _authService;
  final CheckinApi _checkinApi;

  StreamSubscription _checkinSub;

  bool _isReady = false;
  bool get isReady => _isReady;

  Map<int, Checkin> _checkinMap;
  Map<int, Checkin> get checkinMap => _checkinMap;

  int _firstDayOfWeekOffset = 0;
  int get firstDayOfWeekOffset => _firstDayOfWeekOffset;

  int _daysInMonth = 0;
  int get daysInMonth => _daysInMonth;

  Future onInit(int year, int month) async {
    final user = await _authService.user;

    final startDate = DateTime(year, month);
    final endDate = DateTime(year, month + 1, 0, 23, 59, 59, 999, 999);
    _firstDayOfWeekOffset = (startDate.weekday % 7) * -1;
    _daysInMonth = endDate.day;
    _checkinSub =
        _checkinApi.streamCheckinsForTimeRange(user.uid, startDate, endDate).where((x) => x != null).listen((checkins) {
      _isReady = true;
      _checkinMap = _generateCheckinMap(checkins);
      notifyListeners();
    });
  }

  static Map<int, Checkin> _generateCheckinMap(List<Checkin> checkins) {
    if (checkins == null) {
      return <int, Checkin>{};
    }
    return checkins.fold<Map<int, Checkin>>(<int, Checkin>{}, (a, c) {
      final key = c.timestamp.day;
      if (!a.containsKey(key)) {
        a[c.timestamp.day] = c;
      }
      return a;
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
