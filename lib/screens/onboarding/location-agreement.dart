import 'package:flutter/material.dart';
import 'package:vital_circle/themes/typography.dart';

import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';
import 'location-agreement.vm.dart';

class LocationAgreementScreen extends StatelessWidget {
  const LocationAgreementScreen({@required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LocationAgreementViewModel>(
      model: LocationAgreementViewModel.of(onNext, context),
      builder: (context, model, child) {
        return Scaffold(body: Builder(builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  child: Text('Location Sharing', style: AppTypography.h1),
                  padding: EdgeInsets.symmetric(vertical: Spacers.lg),
                ),
                const Expanded(
                    child: Center(
                        child: Text(
                            'TODO: some graphic and text explaining why to share their location.'))),
                const SizedBox(height: Spacers.md),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ProgressButton(
                        label: 'Skip',
                        isProcessing: model.isSaving,
                        onPressed: () => model.onSelect(false),
                        type: ProgressButtonType.Flat,
                      ),
                    ),
                    Expanded(
                      child: ProgressButton(
                        label: 'Accept',
                        isProcessing: model.isSaving,
                        onPressed: () => model.onSelect(true),
                        type: ProgressButtonType.Raised,
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }));
      },
    );
  }
}
