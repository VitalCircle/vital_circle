import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:vital_circle/services/services.dart';

class ConfirmSignOutViewModel extends ChangeNotifier {
  ConfirmSignOutViewModel.of(BuildContext context)
      : _authService = Provider.of(context);

  final AuthService _authService;

  Future signOut(BuildContext context) async {
    await _authService.signOut(context);
  }
}
