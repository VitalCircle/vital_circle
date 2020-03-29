import 'package:flutter/material.dart';
import 'package:teamtemp/constants/images.dart';
import 'package:teamtemp/shared/shared.dart';
import 'package:teamtemp/themes/theme.dart';

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
          const SizedBox(height: 100),
          const FractionallySizedBox(widthFactor: 0.3, child: Image(image: AssetImage(Images.LOGO))),
          const SizedBox(height: Spacers.lg),
          Text('Vital', style: Theme.of(context).textTheme.display3.copyWith(color: AppColors.brandPrimary)),
          Text('Circle', style: Theme.of(context).textTheme.display3.copyWith(color: AppColors.brandSecondary)),
          const Spacer(),
          Image(image: AssetImage(Images.BOOT_WORLD), fit: BoxFit.fitWidth),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );
  }
}
