import 'package:flutter/material.dart';
import 'package:vital_circle/constants/images.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';

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
        return _buildScreen(context);
      },
    );
  }

  Widget _buildScreen(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.secondary100),
      child: Column(
        children: [
          LogoHeader(),
          const Spacer(),
          Image(image: AssetImage(Images.BOOT_WORLD), fit: BoxFit.fitWidth),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );
  }
}
