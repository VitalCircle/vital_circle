import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:teamtemp/constants/log_zone.dart';
import 'package:teamtemp/routes.dart';
import 'package:teamtemp/services/log/log.service.dart';
import 'package:teamtemp/services/services.dart';

class GoogleSignInViewModel extends ChangeNotifier {
  GoogleSignInViewModel.of(BuildContext context) : _googleAuthService = Provider.of(context);

  final GoogleAuthService _googleAuthService;
  final _log = LogService.zone(LogZone.AUTH);

  Future<bool> signIn(BuildContext context) async {
    try {
      if (await _googleAuthService.signIn()) {
        Navigator.pushNamedAndRemoveUntil(context, RouteName.Dashboard, (_) => true);
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
