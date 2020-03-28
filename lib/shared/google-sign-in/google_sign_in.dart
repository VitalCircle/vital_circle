import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teamtemp/constants/sign_in_exception_type.dart';
import 'package:teamtemp/shared/base_widget.dart';
import 'package:teamtemp/themes/theme.dart';

import 'google_sign_in.vm.dart';

const double SOCIAL_BUTTON_WIDTH = 250;

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({@required this.onBusyToggle});

  final Function(bool) onBusyToggle;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<GoogleSignInViewModel>(
        model: GoogleSignInViewModel.of(context), builder: (context, model, child) => _buildButton(context, model));
  }

  Widget _buildButton(BuildContext context, GoogleSignInViewModel model) {
    return RaisedButton(
      splashColor: Colors.grey,
      onPressed: () async {
        await _signIn(context, model);
      },
      padding: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      highlightElevation: 0,
      color: AppColors.google,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: const Image(
              image: AssetImage('assets/google_logo.png'),
              height: 18,
            ),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
            padding: const EdgeInsets.all(8),
          ),
          const Spacer(
            flex: 1,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text('Continue with Google'),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }

  Future<void> _signIn(BuildContext context, GoogleSignInViewModel model) async {
    try {
      onBusyToggle(true);
      if (!await model.signIn(context)) {
        onBusyToggle(false);
      }
    } catch (error) {
      onBusyToggle(false);
      String message = 'Failed to sign-in.';
      if (error is PlatformException &&
          error.code == SignInExceptionType.ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL) {
        message = 'Account exists for a different sign-in method.';
      }
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }
}
