import 'package:flutter/material.dart';
import 'package:teamtemp/shared/shared.dart';

import 'boot.vm.dart';

class BootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<BootViewModel>(
      model: BootViewModel.of(context),
      onModelReady: (model) {
        model.onInit(context);
      },
      builder: (context, model, child) {
        return Scaffold(body: Center(child: Loading()));
      },
    );
  }
}
