import 'package:flutter/material.dart';

import 'legal.dart';

class PrivacyAgreementScreen extends LegalAgreementScreen {
  const PrivacyAgreementScreen({@required this.onNext}) : super(title: 'Privacy Agreement', content: LOREM_IPSUM);

  final VoidCallback onNext;

  @override
  void onAccept() {
    // TODO: Persist
    onNext();
  }
}
