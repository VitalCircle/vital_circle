import 'package:flutter/material.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';

import 'checkup_history.vm.dart';
import 'checkup_list.dart';

const double BIG_FAB_ICON_SIZE = 48;
const double BIG_FAB_SIZE = 94;

class CheckupHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<CheckupHistoryViewModel>(
      model: CheckupHistoryViewModel.of(context),
      onModelReady: (model) {
        model.onInit();
      },
      builder: (context, model, child) {
        return _buildScreen(context, model);
      },
    );
  }

  Widget _buildScreen(BuildContext context, CheckupHistoryViewModel model) {
    if (!model.isReady) {
      return _buildLoading();
    }
    if (model.checkups.isEmpty) {
      return _buildEmptyState(context);
    }
    return _buildCheckupScreen(context, model);
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('No checkups yet!'),
          const SizedBox(height: Spacers.lg),
          SizedBox(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteName.Checkup);
              },
              child: const Icon(Icons.add, size: BIG_FAB_ICON_SIZE),
            ),
            height: BIG_FAB_SIZE,
            width: BIG_FAB_SIZE,
          ),
          const SizedBox(height: Spacers.md),
          const Text('ADD CHECKUP'),
        ],
      ),
    );
  }

  Widget _buildCheckupScreen(BuildContext context, CheckupHistoryViewModel model) {
    return CheckupListScreen(checkups: model.checkups);
  }
}
