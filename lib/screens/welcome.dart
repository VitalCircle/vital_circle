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
        child: Container(
          decoration: const BoxDecoration(color: AppColors.secondary800),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: const Image(
                    image: AssetImage(Images.WELCOME_WORLD),
                    fit: BoxFit.fitWidth),
              ),
              Center(
                child: Column(
                  children: [
                    LogoHeader(),
                    const SizedBox(height: Spacers.xl),
                    Container(
                      child: Text(
                        'Are you ready to save the world?',
                        style: Theme.of(context)
                            .textTheme
                            .display3
                            .copyWith(color: AppColors.whiteHighEmphasis),
                        textAlign: TextAlign.center,
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: Spacers.lg),
                    ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
