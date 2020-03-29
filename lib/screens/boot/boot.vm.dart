import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:teamtemp/routes.dart';
import 'package:teamtemp/services/services.dart';

class BootViewModel extends ChangeNotifier {
  BootViewModel.of(BuildContext context)
      : _googleAuthService = Provider.of(context);

  final GoogleAuthService _googleAuthService;

  Future onInit(BuildContext context) async {
    if (await _googleAuthService.signInSilently()) {
      Navigator.pushReplacementNamed(context, RouteName.Dashboard);
    } else {
      Navigator.pushReplacementNamed(context, RouteName.Welcome);
    }
  }
}
