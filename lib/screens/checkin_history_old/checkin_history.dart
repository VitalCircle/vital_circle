import 'package:flutter/material.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';

import 'checkin_history.vm.dart';
import 'checkin_list.dart';

const double BIG_FAB_ICON_SIZE = 48;
const double BIG_FAB_SIZE = 94;

class CheckinHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<CheckinHistoryViewModel>(
      model: CheckinHistoryViewModel.of(context),
      onModelReady: (model) {
        model.onInit();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: SharedAppBar(
            title: const Text('History'),
          ),
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return _buildScreen(context, model);
            },
          ),
        );
      },
    );
  }

  Widget _buildScreen(BuildContext context, CheckinHistoryViewModel model) {
    if (!model.isReady) {
      return _buildLoading();
    }
    if (model.checkins.isEmpty) {
      return _buildEmptyState(context);
    }
    return _buildCheckinScreen(context, model);
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
          const Text('No checkins yet!'),
          const SizedBox(height: Spacers.lg),
          SizedBox(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteName.Checkin);
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

  Widget _buildCheckinScreen(BuildContext context, CheckinHistoryViewModel model) {
    return CheckinListScreen(checkins: model.checkins);
  }
}
