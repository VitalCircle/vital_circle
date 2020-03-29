import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

PreferredSizeWidget appBarPage(BuildContext context, String id) {
  return AppBar(
    title: Text(id),
    centerTitle: true,
    actions: appBarActions(context),
  );
}

List<Widget> appBarActions(BuildContext context) {
  return [
    IconButton(
      icon: Icon(FontAwesomeIcons.home, color: Colors.black54),
      onPressed: () =>
          Navigator.popUntil(context, ModalRoute.withName('/dashboard')),
    ),
  ];
}
