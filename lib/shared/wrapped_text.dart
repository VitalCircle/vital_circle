import 'package:flutter/material.dart';

class WrappedText extends StatelessWidget {
  const WrappedText({@required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[Flexible(child: child)],
      ),
    );
  }
}
