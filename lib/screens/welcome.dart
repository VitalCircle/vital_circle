import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vital_circle/constants/images.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isBusy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _isBusy,
        color: AppColors.modalBackground,
        child: Column(
          children: [
            LogoHeader(),
            const SizedBox(height: Spacers.xl),
            Expanded(
              child: Center(
                child: AuthButtons(onBusyToggle: (bool isBusy) {
                  setState(() {
                    _isBusy = isBusy;
                  });
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
