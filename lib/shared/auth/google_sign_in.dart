import 'package:vital_circle/constants/images.dart';
import 'package:vital_circle/themes/theme.dart';
import 'package:flutter/material.dart';

import 'sign_in.dart';

class GoogleSignInButton extends SignInButton {
  GoogleSignInButton({
    Key key,
    Function onPressed,
  }) : super(
          key: key,
          onPressed: onPressed,
          icon: Container(
            child: const Image(
              image: AssetImage(Images.GOOGLE),
              height: 18,
            ),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
            padding: const EdgeInsets.all(8),
          ),
          label: 'Yes, continue with Google',
          backgroundColor: AppColors.googleBtnBackground,
          fontColor: AppColors.textLight,
        );
}
