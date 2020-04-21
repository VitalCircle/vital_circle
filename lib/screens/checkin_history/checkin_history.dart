import 'package:flutter/material.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/colors.dart';
import 'package:vital_circle/themes/theme.dart';

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
            title: 'History',
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.business, size: 28.0),
                onPressed: () {},
              ),
              const SizedBox(width: Spacers.md),
            ],
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
