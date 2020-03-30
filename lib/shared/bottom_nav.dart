import 'package:flutter/material.dart';

import 'package:teamtemp/themes/theme.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget fabAdd(BuildContext context) {
  return fab(context, Icons.add, () {});
}

Widget fab(BuildContext context, IconData icon, Function onPressed) {
  return FloatingActionButton(
      backgroundColor: AppColors.whiteHighEmphasis,
      child: Icon(icon, color: Colors.black),
      shape: const CircleBorder(side: BorderSide(width: 2)),
      onPressed: onPressed);
}

Widget bottomNav(BuildContext context) {
  return BottomNavigationBar(
    backgroundColor: AppColors.primary200,
    selectedItemColor: AppColors.primaryTextColor,
    unselectedItemColor: AppColors.whiteHighEmphasis,
    type: BottomNavigationBarType.fixed,
    items: const [
      BottomNavigationBarItem(title: Text('Home'), icon: Icon(FontAwesomeIcons.home)),
      BottomNavigationBarItem(title: Text('Entries'), icon: Icon(FontAwesomeIcons.edit)),
      BottomNavigationBarItem(title: Text('Stats'), icon: Icon(FontAwesomeIcons.chartBar)),
      BottomNavigationBarItem(title: Text('Calendar'), icon: Icon(FontAwesomeIcons.calendarAlt)),
    ],
    currentIndex: 0,
  );
}
