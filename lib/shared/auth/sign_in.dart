import 'package:flutter/material.dart';

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
    return RaisedButton(
      splashColor: Colors.grey,
      onPressed: () {
        onPressed();
      },
      padding: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      highlightElevation: 0,
      color: backgroundColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon,
          const Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              label,
              style: Theme.of(context).textTheme.button.copyWith(color: fontColor),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
