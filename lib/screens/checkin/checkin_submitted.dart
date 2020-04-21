import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:vital_circle/constants/images.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';

class CheckinSubmittedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppBar(
        // empty container used to hide back button
        leading: Container(),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName(RouteName.Dashboard)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacers.xl + Spacers.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildThankYou(context),
            Expanded(flex: 1, child: _buildNumberContributing()),
            Expanded(flex: 1, child: _buildShare()),
          ],
        ),
      ),
    );
  }

  Widget _buildThankYou(BuildContext context) {
    return Column(
      children: <Widget>[
        Image(
          image: AssetImage(Images.GLOBE),
          width: MediaQuery.of(context).size.width / 4,
        ),
        _stdSpacing(),
        Text('Thank you!', style: AppTypography.h1),
        _stdSpacing(),
        Text('Please check-in again tomorrow.', style: AppTypography.bodyRegular1)
      ],
    );
  }

  Widget _buildNumberContributing() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('2,468,158 people are contributing', style: AppTypography.h3),
        _stdSpacing(),
        Text(
            'Your contribution helps to keep you and millions of others safe. Tracking your symptoms every day will help fight the COVID pandemic!',
            style: AppTypography.bodyRegular1,
            textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildShare() {
    return Column(
      children: <Widget>[
        Text('Share to stop the spread.', style: AppTypography.bodyRegular1),
        _stdSpacing(),
        ProgressButton(
          label: 'Share',
          isHalfWidth: true,
          onPressed: () =>
              Share.share('Vital Circle is awesome! Help stop the spread of COVID-19! https://vitalcircle.dev'),
          type: ProgressButtonType.Raised,
        ),
      ],
    );
  }

  Widget _stdSpacing() => const SizedBox(height: Spacers.md);
}
