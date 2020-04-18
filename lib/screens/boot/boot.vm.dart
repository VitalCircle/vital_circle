import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:vital_circle/services/services.dart';

class BootViewModel extends ChangeNotifier {
  BootViewModel.of(BuildContext context) : _startupService = Provider.of(context);

  final StartUpService _startupService;

  Future onInit(BuildContext context) async {
    await _startupService.next(context);
  }
}
