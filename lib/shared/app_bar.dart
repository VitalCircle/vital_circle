import 'package:flutter/material.dart';

class SharedAppBar extends AppBar {
  SharedAppBar({Widget title, List<Widget> actions})
      : super(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: title,
          actions: actions,
        );
}
