import 'package:flutter/material.dart';

import 'package:vital_circle/shared/shared.dart';
import 'legal.dart';
import 'privacy-agreement.vm.dart';

class PrivacyAgreementScreen extends StatelessWidget {
  const PrivacyAgreementScreen({@required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PrivacyViewModel>(
      model: PrivacyViewModel.of(onNext, context),
      builder: (context, model, child) {
        return LegalAgreementScreen(
          title: 'Privacy Policy',
          content: LOREM_IPSUM,
          onAccept: model.onAccept,
          isProcessing: model.isSaving,
        );
      },
    );
  }
}
