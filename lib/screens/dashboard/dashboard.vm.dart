import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../services/services.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel.of(BuildContext context) : _geoService = Provider.of(context);

  final GeoService _geoService;

  Future onInit() async {
    _geoService.startPolling();
  }

  @override
  void dispose() {
    _geoService.stopPolling();
    super.dispose();
  }
}
