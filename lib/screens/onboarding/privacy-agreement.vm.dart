import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:vital_circle/services/services.dart';

class PrivacyViewModel extends ChangeNotifier {
  PrivacyViewModel.of(this.onNext, BuildContext context)
      : _authService = Provider.of(context),
        _userApi = Provider.of(context);

  final VoidCallback onNext;
  final AuthService _authService;
  final UserApi _userApi;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  Future<void> onAccept() async {
    if (_isSaving) {
      notifyListeners();
      return;
    }
    _isSaving = true;
    notifyListeners();

    try {
      final user = await _authService.user;
      await _userApi.updatePrivacyAgreement(user.uid);
      onNext();
      return;
    } catch (_) {
      _isSaving = false;
      notifyListeners();
      rethrow;
    }
  }
}
