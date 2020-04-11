import 'package:flutter/material.dart';

import '../../shared/shared.dart';
import 'legal.dart';
import 'tos-agreement.vm.dart';

class TermsOfServiceAgreementScreen extends StatelessWidget {
  const TermsOfServiceAgreementScreen({@required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TermsOfServiceViewModel>(
      model: TermsOfServiceViewModel.of(onNext, context),
      builder: (context, model, child) {
        return LegalAgreementScreen(
          title: 'Terms of Service',
          content: LOREM_IPSUM,
          onAccept: model.onAccept,
          isProcessing: model.isSaving,
        );
      },
    );
  }
}
