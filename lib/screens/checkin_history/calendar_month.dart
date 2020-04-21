import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vital_circle/extensions/index.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';
import 'package:vital_circle/themes/typography.dart';

import 'calendar_month.vm.dart';

const DAY_SIZE = 32.0;
const CHECKIN_STATUS_SIZE = 8.0;

enum CalendarDayState { None, Good, Bad }

class CalendarDay {
  CalendarDay(this.dayOfMonth, this.state);
  int dayOfMonth;
  CalendarDayState state;
}

class CalendarMonth extends StatelessWidget {
  const CalendarMonth({@required this.year, @required this.month, @required this.onSelectDay});

  final int year;
  final int month;
  final Function(DateTime, Checkin) onSelectDay;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CalendarMonthViewModel>(
      model: CalendarMonthViewModel.of(context),
      onModelReady: (model) {
        model.onInit(year, month);
      },
      builder: (context, model, child) {
        return model.isReady ? _buildScreen(context, model) : _buildLoading();
      },
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildScreen(BuildContext context, CalendarMonthViewModel model) {
    final weeks = <Widget>[];
    for (var i = model.firstDayOfWeekOffset; i < model.daysInMonth; i += 7) {
      final row = _buildRow(model, i, i + 6);
      weeks.add(row);
    }

    final monthName = _getMonthName();
    const rowSpacer = SizedBox(height: 24);
    return Column(
      children: <Widget>[
        Text(monthName, style: AppTypography.h2),
        rowSpacer,
        ...weeks.intersperse(rowSpacer),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  String _getMonthName() {
    var monthName = DateFormat.MMMM().format(DateTime(year, month));
    if (DateTime.now().year != year) {
      monthName += ' $year';
    }
    return monthName;
  }

  Widget _buildRow(CalendarMonthViewModel model, int startDayIndex, int endDayIndex) {
    final days = <Widget>[];
    for (var i = startDayIndex; i <= endDayIndex; i++) {
      final day = _buildDay(model, i);
      days.add(day);
    }
    return Row(
      children: days,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget _buildDay(CalendarMonthViewModel model, int dayIndex) {
    final day = dayIndex + 1;
    final now = DateTime.now();
    final date = DateTime(year, month, day);
    final dateCompare = now.compareDate(date);
    final isToday = dateCompare == 0;
    final isFuture = dateCompare < 0;
    final title = day > 0 && day <= model.daysInMonth ? day.toString() : '';
    final checkin = model.checkinMap[day];
    final dayBackgroundColor = isToday ? AppColors.today : Colors.transparent;
    final dayColor = isFuture ? AppColors.disabled : AppColors.primary;
    final checkinColor = _getDayCheckinColor(checkin);

    return InkWell(
      child: Container(
        width: DAY_SIZE,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: dayBackgroundColor),
              child: Center(child: Text(title, style: AppTypography.calendarDay.copyWith(color: dayColor))),
              height: DAY_SIZE,
              width: DAY_SIZE,
            ),
            const SizedBox(height: 4),
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: checkinColor),
              height: CHECKIN_STATUS_SIZE,
              width: CHECKIN_STATUS_SIZE,
            )
          ],
        ),
      ),
      onTap: isFuture
          ? null
          : () {
              final date = DateTime(year, month, day);
              onSelectDay(date, checkin);
            },
    );
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
