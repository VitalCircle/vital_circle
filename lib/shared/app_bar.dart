import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:teamtemp/routes.dart';
import 'package:teamtemp/themes/colors.dart';

PreferredSizeWidget appBarPage(BuildContext context, String id) {
  return AppBar(
    leading: appBarLeadingAction(context),
    title: Text(id),
    centerTitle: true,
    // actions: appBarTrailingActions(context),
  );
}

Widget appBarLeadingAction(BuildContext context) {
  return IconButton(
    icon: Icon(FontAwesomeIcons.home, color: AppColors.whiteHighEmphasis),
    onPressed: () => Navigator.popUntil(context, ModalRoute.withName(RouteName.Dashboard)),
  );
}

List<Widget> appBarTrailingActions(BuildContext context) {
  return [
    IconButton(
      icon: Icon(FontAwesomeIcons.userCircle, color: AppColors.whiteHighEmphasis),
      onPressed: () => Scaffold.of(context).openEndDrawer(),
    ),
    const SizedBox(width: 12)
  ];
}
