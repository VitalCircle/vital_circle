import 'package:flutter/material.dart';
import 'package:vital_circle/themes/theme.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({Key key, this.onPressed, this.icon, this.label, this.backgroundColor, this.fontColor})
      : super(key: key);

  final Function onPressed;
  final Widget icon;
  final String label;
  final Color backgroundColor;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: BUTTON_HEIGHT,
      child: RaisedButton(
        splashColor: Colors.grey,
        onPressed: () {
          onPressed();
        },
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(BUTTON_BORDER_RADIUS)),
        highlightElevation: 0,
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 48,
              child: Center(child: icon),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                label,
                style: Theme.of(context).textTheme.button.copyWith(color: fontColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
