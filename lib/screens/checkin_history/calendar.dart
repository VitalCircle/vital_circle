import 'package:flutter/material.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/screens/checkin_history/checkin_details.dart';
import 'package:vital_circle/themes/theme.dart';

import 'calendar_month.dart';

// allow for 5 years in the past
const TODAY_MONT_INDEX = 12 * 5;

class Calendar extends StatefulWidget {
  const Calendar({@required this.checkins});

  final List<Checkin> checkins;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final PageController _pageController = PageController(
    initialPage: TODAY_MONT_INDEX,
    viewportFraction: 0.8,
  );

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Container(
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          final monthIndex = index - TODAY_MONT_INDEX;
          final date = DateTime(today.year, today.month + monthIndex);
          return CalendarMonth(
            year: date.year,
            month: date.month,
            onSelectDay: (date, checkin) {
              _onSelectDay(context, date, checkin);
            },
          );
        },
        pageSnapping: true,
        scrollDirection: Axis.vertical,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }

  void _onSelectDay(BuildContext context, DateTime date, Checkin checkin) {
    showModalBottomSheet<Widget>(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.6,
            widthFactor: 1,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                boxShadow: AppShadows.s2,
              ),
              child: CheckinDetails(checkin: checkin, date: date),
            ),
          );
        });
  }
}
