import 'package:teamtemp/shared/base_widget.dart';
import 'package:flutter/material.dart';

import 'confirm_sign_out.vm.dart';

class ConfirmSignOutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<ConfirmSignOutViewModel>(
      model: ConfirmSignOutViewModel.of(context),
      builder: (context, model, child) => _buildDialog(context, model),
    );
  }

  Widget _buildDialog(BuildContext context, ConfirmSignOutViewModel model) {
    return AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: <Widget>[
          FlatButton(
            child: const Text('NO'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          FlatButton(
            child: const Text('YES, LOG OUT'),
            onPressed: () async {
              await model.signOut(context);
            },
          )
        ]);
  }
}
