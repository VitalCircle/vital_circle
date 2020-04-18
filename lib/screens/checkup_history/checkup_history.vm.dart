import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vital_circle/models/index.dart';

import '../../services/services.dart';

class CheckupHistoryViewModel extends ChangeNotifier {
  CheckupHistoryViewModel.of(BuildContext context)
      : _authService = Provider.of(context),
        _checkupApi = Provider.of(context);

  final AuthService _authService;
  final CheckupApi _checkupApi;

  StreamSubscription _checkupSub;

  bool _isReady = false;
  bool get isReady => _isReady;

  List<Checkup> _checkups;
  List<Checkup> get checkups => _checkups;

  Future onInit() async {
    final userId = _authService.user.uid;
    _checkupSub = _checkupApi.streamCheckups(userId).where((x) => x != null).listen((checkups) {
      _isReady = true;
      _checkups = checkups;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    if (_checkupSub != null) {
      _checkupSub.cancel();
    }
    super.dispose();
  }
}
