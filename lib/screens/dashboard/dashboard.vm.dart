import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel.of(BuildContext context);

  Future onInit() async {
    // TODO: start polling GPS location
  }

  @override
  void dispose() {
    // TODO: stop polling GPS location
    super.dispose();
  }
}
