import 'package:vital_circle/constants/sign_in_exception_type.dart';
import 'package:vital_circle/enums/auth_provider_type.dart';
import 'package:vital_circle/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../base_widget.dart';
import 'anonymous_sign_in.dart';
import 'auth_buttons.vm.dart';
import 'google_sign_in.dart';

const double SOCIAL_BUTTON_WIDTH = 300;

class AuthButtons extends StatelessWidget {
  const AuthButtons({@required this.onBusyToggle});

  final Function(bool) onBusyToggle;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AuthButtonsViewModel>(
        model: AuthButtonsViewModel.of(context),
        builder: (context, model, child) => Column(
              children: <Widget>[
                SizedBox(
                    width: SOCIAL_BUTTON_WIDTH,
                    child: GoogleSignInButton(onPressed: () async => _signIn(context, AuthProviderType.google, model))),
                const SizedBox(height: Spacers.sm),
                SizedBox(
                    width: SOCIAL_BUTTON_WIDTH,
                    child: AnonymousSignInButton(
                      onPressed: () async => _signIn(context, AuthProviderType.anonymous, model),
                    ))
              ],
              mainAxisSize: MainAxisSize.min,
            ));
  }

  Future<void> _signIn(BuildContext context, AuthProviderType providerType, AuthButtonsViewModel model) async {
    try {
      onBusyToggle(true);
      if (!await model.signIn(context, providerType)) {
        onBusyToggle(false);
      }
    } catch (error) {
      onBusyToggle(false);
      String message = 'Failed to sign in.';
      if (error is PlatformException &&
          error.code == SignInExceptionType.ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL) {
        message = 'Account exists for a different sign in method.';
      }
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }
}
