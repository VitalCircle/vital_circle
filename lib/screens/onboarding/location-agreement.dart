import 'package:flutter/material.dart';

import '../../shared/shared.dart';
import '../../themes/theme.dart';
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
                  child: Text('Location Sharing', style: Theme.of(context).textTheme.display2),
                  padding: EdgeInsets.symmetric(vertical: Spacers.lg),
                ),
                const Expanded(
                    child: Center(child: Text('TODO: some graphic and text explaining why to share their location.'))),
                SizedBox(height: Spacers.md),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ProgressButton(
                        label: const Text('Skip'),
                        isProcessing: model.isSaving,
                        onPressed: () => model.onSelect(false),
                        type: ProgressButtonType.Flat,
                      ),
                    ),
                    Expanded(
                      child: ProgressButton(
                        color: AppColors.buttonColorSelectedGood,
                        label: const Text('Accept'),
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
