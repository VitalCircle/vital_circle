import 'package:vital_circle/shared/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:vital_circle/themes/spacers.dart';

import 'confirm_sign_out.vm.dart';

class ConfirmSignOutDialog extends StatelessWidget {
  const ConfirmSignOutDialog({@required bool isAnonymous})
      : _isAnonymous = isAnonymous;

  final bool _isAnonymous;

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
        content: Column(
          children: _getContent(context),
          mainAxisSize: MainAxisSize.min,
        ),
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

  List<Widget> _getContent(BuildContext context) {
    final widgets = <Widget>[const Text('Are you sure you want to log out?')];
    if (_isAnonymous) {
      widgets.addAll([
        const SizedBox(height: Spacers.md),
        Text('Since you are anonymous you will lose all of your data.',
            style: Theme.of(context).textTheme.body1.copyWith(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.bold))
      ]);
    }
    return widgets;
  }
}
