import 'package:flutter/material.dart';

import 'legal.dart';

class TermsOfServiceAgreementScreen extends LegalAgreementScreen {
  const TermsOfServiceAgreementScreen({@required this.onNext}) : super(title: 'Terms of Service', content: LOREM_IPSUM);

  final VoidCallback onNext;

  @override
  void onAccept() {
    // TODO: Persist
    onNext();
  }
}
