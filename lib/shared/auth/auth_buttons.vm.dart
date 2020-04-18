import 'package:vital_circle/services/auth/auth.service.dart';
import 'package:vital_circle/services/log/log.service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:vital_circle/enums/auth_provider_type.dart';
import 'package:vital_circle/constants/log_zone.dart';
import 'package:provider/provider.dart';
import 'package:vital_circle/services/services.dart';

class AuthButtonsViewModel extends ChangeNotifier {
  AuthButtonsViewModel.of(BuildContext context)
      : _authService = Provider.of(context),
        _startUpService = Provider.of(context);

  final AuthService _authService;
  final StartUpService _startUpService;
  final _log = LogService.zone(LogZone.AUTH);

  Future<bool> signIn(BuildContext context, AuthProviderType providerType) async {
    try {
      if (await _authService.socialSignIn(providerType)) {
        await _startUpService.next(context);
        return true;
        // don't reset busy so that the spinner remains till the page transitions
      }
      return false;
    } catch (error, stack) {
      _log.error(error, stack);
      rethrow;
    }
  }
}
