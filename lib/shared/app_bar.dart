import 'package:flutter/material.dart';

class SharedAppBar extends AppBar {
  SharedAppBar({Widget title, List<Widget> actions, Widget leading})
      : super(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            title: title,
            actions: actions,
            leading: leading);
}
