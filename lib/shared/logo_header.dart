import 'package:flutter/material.dart';
import 'package:vital_circle/constants/images.dart';

const LOGO_FONT_SIZE = 48.0;

class LogoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const FractionallySizedBox(widthFactor: 0.5, child: Image(image: AssetImage(Images.LOGO))),
      margin: const EdgeInsets.symmetric(vertical: 100),
    );
  }
}
