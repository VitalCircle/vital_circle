import 'package:flutter/material.dart';
import 'package:vital_circle/shared/shared.dart';

import 'calendar.dart';
import 'checkin_history.vm.dart';

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
              return Calendar(checkins: model.checkins);
            },
          ),
        );
      },
    );
  }
}
