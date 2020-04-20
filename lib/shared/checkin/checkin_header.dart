import 'package:flutter/material.dart';
import 'package:vital_circle/screens/checkin/checkin.vm.dart';
import 'package:vital_circle/themes/theme.dart';

Widget checkinHeader(BuildContext context, CheckinViewModel model,
    String titleText, String subtitleText) {
  return Column(children: [
    Text(titleText, style: AppTypography.h2),
    const SizedBox(height: Spacers.sm),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacers.md),
      child: Text(
        subtitleText,
        style: AppTypography.bodyRegular1,
        textAlign: TextAlign.center,
      ),
    ),
    const SizedBox(height: Spacers.lg),
  ]);
}
