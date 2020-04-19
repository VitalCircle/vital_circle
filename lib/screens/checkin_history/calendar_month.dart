import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vital_circle/extensions/index.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/themes/theme.dart';
import 'package:vital_circle/themes/typography.dart';

enum CalendarDayState { None, Good, Bad }

class CalendarDay {
  CalendarDay(this.dayOfMonth, this.state);
  int dayOfMonth;
  CalendarDayState state;
}

class CalendarMonth extends StatelessWidget {
  CalendarMonth({@required this.year, @required this.month, this.checkins, @required this.onSelectDay})
      : _checkinMap = _generateCheckinMap(checkins),
        _firstDayOfWeekOffset = (DateTime(year, month).weekday % 7) * -1,
        _daysInMonth = DateTime(year, month + 1, 0).day;

  final int year;
  final int month;
  final List<Checkin> checkins;
  final Function(DateTime) onSelectDay;

  final Map<int, Checkin> _checkinMap;
  final int _firstDayOfWeekOffset;
  final int _daysInMonth;

  @override
  Widget build(BuildContext context) {
    final weeks = <Widget>[];
    for (var i = _firstDayOfWeekOffset; i < _daysInMonth; i += 7) {
      weeks.add(_buildRow(i, i + 7));
    }

    final monthName = DateFormat.MMMM().format(DateTime(year, month));
    const rowSpacer = SizedBox(height: 24);
    return Column(
      children: <Widget>[
        Text(monthName, style: AppTypography.h1),
        rowSpacer,
        ...weeks.intersperse(rowSpacer),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  static Map<int, Checkin> _generateCheckinMap(List<Checkin> checkins) {
    if (checkins == null) {
      return <int, Checkin>{};
    }
    return checkins.fold<Map<int, Checkin>>(<int, Checkin>{}, (a, c) {
      final key = c.timestamp.day;
      if (!a.containsKey(key)) {
        a[c.timestamp.day] = c;
      }
      return a;
    });
  }

  Widget _buildRow(int startDay, int endDay) {
    final days = <Widget>[];
    for (var i = startDay; i < endDay; i++) {
      days.add(_buildDay(i + 1));
    }
    return Row(
      children: days,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget _buildDay(int day) {
    final title = day > 0 && day <= _daysInMonth ? day.toString() : '';
    final checkin = _checkinMap[day];
    final dayColor = _getDayColor(day);
    final checkinColor = _getDayCheckinColor(checkin);
    return InkWell(
      child: Container(
        width: 32,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: dayColor),
              child: Center(child: Text(title, style: AppTypography.calendarDay)),
              height: 32,
              width: 32,
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: checkinColor),
              height: 8,
              width: 8,
            )
          ],
        ),
      ),
      onTap: () {
        final date = DateTime(year, month, day);
        onSelectDay(date);
      },
    );
  }

  Color _getDayColor(int day) {
    final now = DateTime.now();
    if (now.year == year && now.month == month && now.day == day) {
      return AppColors.today;
    }
    return Colors.transparent;
  }

  Color _getDayCheckinColor(Checkin checkin) {
    if (checkin == null) {
      return Colors.transparent;
    }
    if ((checkin.temp != null && checkin.temp > 100) || checkin.subjectiveTemp == 'hot') {
      return AppColors.checkinBad;
    }
    return AppColors.checkinGood;
  }
}
