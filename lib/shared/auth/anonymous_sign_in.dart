import 'package:vital_circle/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'sign_in.dart';

class AnonymousSignInButton extends SignInButton {
  AnonymousSignInButton({
    Key key,
    Function onPressed,
  }) : super(
          key: key,
          onPressed: onPressed,
          icon: Container(
              padding: const EdgeInsets.all(4),
              child: const Icon(
                FontAwesomeIcons.userLock,
                color: AppColors.whiteMediumEmphasis,
              )),
          label: 'Yes, continue Anonymously',
          backgroundColor: AppColors.anonymousBtnBackground,
          fontColor: AppColors.whiteMediumEmphasis,
        );
}
