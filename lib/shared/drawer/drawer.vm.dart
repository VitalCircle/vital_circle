import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:teamtemp/routes.dart';
import 'package:teamtemp/services/services.dart';

class DrawerViewModel extends ChangeNotifier {
  DrawerViewModel.of(BuildContext context) : _authService = Provider.of(context);

  final AuthService _authService;

  bool _isReady = false;
  bool get isReady => _isReady;

  FirebaseUser _user;
  FirebaseUser get user => _user;

  Future init() async {
    _user = await _authService.user;
    _isReady = true;
    notifyListeners();
  }

  Future signOut(BuildContext context) async {
    await _authService.signOut(context);
    Navigator.pushNamedAndRemoveUntil(context, RouteName.Welcome, (_) => false);
  }
}
