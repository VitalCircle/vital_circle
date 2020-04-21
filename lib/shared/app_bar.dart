import 'package:flutter/material.dart';
import 'package:vital_circle/themes/typography.dart';

class SharedAppBar extends AppBar {
  SharedAppBar({String title, List<Widget> actions, Widget leading})
      : super(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            title: Text(title, style: AppTypography.h3),
            actions: actions,
            leading: leading);
}
