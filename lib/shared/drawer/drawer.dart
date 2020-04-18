import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vital_circle/shared/drawer/confirm_sign_out.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';

import 'drawer.vm.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<DrawerViewModel>(
      model: DrawerViewModel.of(context),
      onModelReady: (model) {
        model.init();
      },
      builder: (context, model, child) => model.isReady ? _buildDrawer(context, model) : Container(),
    );
  }

  Widget _buildDrawer(BuildContext context, DrawerViewModel model) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          model.user.isAnonymous ? _drawAnonymousHeader(context) : _drawSocialHeader(model.user),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () async {
              await showDialog<bool>(
                  context: context, builder: (context) => ConfirmSignOutDialog(isAnonymous: model.user.isAnonymous));
            },
          ),
        ],
      ),
    );
  }

  Widget _drawSocialHeader(FirebaseUser user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.displayName ?? ''),
      accountEmail: Text(user.email ?? ''),
      currentAccountPicture: CircleAvatar(backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl) : null),
    );
  }

  Widget _drawAnonymousHeader(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: const Text('Anonymous'),
      accountEmail: const Text(''),
      currentAccountPicture: CircleAvatar(
        child: Text('A', style: AppTypography.h1.copyWith(color: AppColors.textLight)),
      ),
    );
  }
}
