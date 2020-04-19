import 'package:flutter/material.dart';
import 'package:vital_circle/models/index.dart';

import 'calendar_month.dart';

class Calendar extends StatelessWidget {
  const Calendar({@required this.checkins});

  final List<Checkin> checkins;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CalendarMonth(year: 2020, month: 4, checkins: checkins, onSelectDay: _onSelectDay),
      padding: const EdgeInsets.all(24),
    );
  }

  void _onSelectDay(DateTime date) {
    print(date.day.toString());
  }
}
