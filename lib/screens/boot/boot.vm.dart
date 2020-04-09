import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/services/services.dart';

class BootViewModel extends ChangeNotifier {
  BootViewModel.of(BuildContext context) : _authService = Provider.of(context);

  final AuthService _authService;

  Future onInit(BuildContext context) async {
    if (await _authService.signInSilently()) {
      Navigator.pushReplacementNamed(context, RouteName.Onboarding);
    } else {
      Navigator.pushReplacementNamed(context, RouteName.Welcome);
    }
  }
}
