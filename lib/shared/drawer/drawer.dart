import 'package:flutter/material.dart';
import 'package:teamtemp/shared/shared.dart';

import 'drawer.vm.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<DrawerViewModel>(
      model: DrawerViewModel.of(context),
      onModelReady: (model) {
        model.init();
      },
      builder: (context, model, child) =>
          model.isReady ? _buildDrawer(context, model) : Container(),
    );
  }

  Widget _buildDrawer(BuildContext context, DrawerViewModel model) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(model.user.displayName),
            accountEmail: Text(model.user.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(model.user.photoUrl),
            ),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              model.signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
