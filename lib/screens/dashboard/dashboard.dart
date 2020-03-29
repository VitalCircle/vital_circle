import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:teamtemp/services/services.dart';
import 'package:teamtemp/shared/app_bar.dart';
import 'package:teamtemp/shared/shared.dart';
import 'package:teamtemp/themes/theme.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: appBarLeadingAction(context),
        title: const Text('VitalCircle'),
        // actions: appBarTrailingActions(context),
        // actions: <Widget>[
        //   IconButton(
        //       icon: Icon(FontAwesomeIcons.userCircle,
        //           color: AppColors.whiteHighEmphasis),
        //       onPressed: () => DrawerWidget()),
        // ],
      ),
      body: Center(
        child: Text('title'),
      ),
      // endDrawer: Drawer(),
      endDrawer: DrawerWidget(),
    );
  }
}
