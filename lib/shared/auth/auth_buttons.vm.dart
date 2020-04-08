import 'package:teamtemp/routes.dart';
import 'package:teamtemp/services/auth/auth.service.dart';
import 'package:teamtemp/services/log/log.service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:teamtemp/enums/auth_provider_type.dart';
import 'package:teamtemp/constants/log_zone.dart';
import 'package:provider/provider.dart';

class AuthButtonsViewModel extends ChangeNotifier {
  AuthButtonsViewModel.of(BuildContext context) : _authService = Provider.of(context);

  final AuthService _authService;
  final _log = LogService.zone(LogZone.AUTH);

  Future<bool> signIn(BuildContext context, AuthProviderType providerType) async {
    try {
      if (await _authService.socialSignIn(providerType)) {
        Navigator.pushNamedAndRemoveUntil(context, RouteName.Onboarding, (_) => false);
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
