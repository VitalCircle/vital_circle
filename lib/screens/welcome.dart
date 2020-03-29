import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:teamtemp/shared/shared.dart';
import 'package:teamtemp/themes/theme.dart';

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
        child: Center(
          child: SizedBox(
            width: 250,
            child: GoogleSignInButton(
              onBusyToggle: (bool isBusy) {
                setState(() {
                  _isBusy = isBusy;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
