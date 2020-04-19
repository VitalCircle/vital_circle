import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:location_permissions/location_permissions.dart';

import 'package:provider/provider.dart';
import 'package:vital_circle/services/services.dart';

class LocationAgreementViewModel extends ChangeNotifier {
  LocationAgreementViewModel.of(this.onNext, BuildContext context)
      : _authService = Provider.of(context),
        _userApi = Provider.of(context);

  final VoidCallback onNext;
  final AuthService _authService;
  final UserApi _userApi;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  Future<void> onSelect(bool didAccept) async {
    if (_isSaving) {
      notifyListeners();
      return;
    }
    _isSaving = true;
    notifyListeners();

    try {
      if (didAccept) {
        final permission = await LocationPermissions().requestPermissions();
        if (permission != PermissionStatus.granted) {
          _isSaving = false;
          notifyListeners();
          return;
        }
      }

      final user = await _authService.user;
      await _userApi.updateLocationSharingAgreement(user.uid, didAccept);
      onNext();
      return;
    } catch (_) {
      _isSaving = false;
      notifyListeners();
      rethrow;
    }
  }
}
