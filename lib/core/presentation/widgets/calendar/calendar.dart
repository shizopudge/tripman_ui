import 'package:flutter/material.dart';

import '../../animations/fade_animation_y_up.dart';
import '../../../utils/date_format_util.dart';
import '../../../styles/styles.dart';
import '../buttons/rounded_text_button.dart';
import '../common/bottom_container.dart';
import 'default_day.dart';
import 'disabled_day.dart';
import 'interval_point.dart';
import 'marked_day.dart';

class Calendar extends StatefulWidget {
  final ValueNotifier<DateTimeRange?> _selectedIntervalNotifier;
  final DateTimeRange? availableRange;
  const Calendar({
    super.key,
    required ValueNotifier<DateTimeRange?> selectedIntervalNotifier,
    this.availableRange,
  }) : _selectedIntervalNotifier = selectedIntervalNotifier;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  static const int monthCount = 12;
  final DateTime now = DateTime.now();
  final int currentDay = DateTime.now().day;

  late final ValueNotifier<DateTimeRange?> _calendarSelectedIntervalNotifier;

  final List<DateTime> pastDaysOfTheMonth = [];
  final List<int> lastPeviousMonthDays = [];
  final List<DateTime> availableDates = [];

  @override
  void initState() {
    _setPastDaysOfTheMonth();
    if (widget.availableRange != null) {
      _setAvailableDates(
        startDate: widget.availableRange!.start,
        endDate: widget.availableRange!.end,
      );
    }
    _calendarSelectedIntervalNotifier =
        ValueNotifier<DateTimeRange?>(widget._selectedIntervalNotifier.value);
    super.initState();
  }

  @override
  void dispose() {
    _calendarSelectedIntervalNotifier.dispose();
    super.dispose();
  }

  void _setAvailableDates(
      {required DateTime startDate, required DateTime endDate}) {
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      availableDates.add(
        DateTime(
          startDate.year,
          startDate.month,
          startDate.day + i,
        ),
      );
    }
  }

  void _setPastDaysOfTheMonth() {
    for (int j = 0; j < currentDay; j++) {
      pastDaysOfTheMonth.add(DateTime(now.year, now.month, j + 1));
    }
  }

  ({int month, int year, int startWeekday}) _getMonthAndYearAndStartWeekday(
          {required int index}) =>
      (
        month: DateTime(now.year, now.month + index, now.day).month,
        year: DateTime(now.year, now.month + index, now.day).year,
        startWeekday: DateTime(now.year, now.month + index, 1).weekday - 1,
      );

  int _getPreviousMonthDayCount({required int year, required int month}) {
    if (month > 1) {
      return DateUtils.getDaysInMonth(year, month - 1);
    } else {
      return DateUtils.getDaysInMonth(year - 1, 12);
    }
  }

  void _setLastPeviousMonthDays(
      {required int startWeekday, required int previousMonthDayCount}) {
    lastPeviousMonthDays.clear();
    int day = previousMonthDayCount;
    for (int i = 0; i <= startWeekday - 1; i++) {
      lastPeviousMonthDays.add(day);
      day -= 1;
    }
  }

  DateTime _generateDateTime(
          {required int index,
          required ({int month, int year, int startWeekday}) r}) =>
      DateTime(
        r.year,
        r.month,
        index - 6 - r.startWeekday,
      );

  bool _isDayPassed(
          {required int index,
          required ({int month, int year, int startWeekday}) r}) =>
      pastDaysOfTheMonth.contains(_generateDateTime(index: index, r: r)) &&
      r.month == now.month;

  bool _isDayUnavailable({
    required int index,
    required ({int month, int year, int startWeekday}) r,
  }) {
    if (widget.availableRange == null) {
      return _isDayPassed(
        index: index,
        r: r,
      );
    } else {
      final DateTime date = _generateDateTime(index: index, r: r);
      if (!availableDates.contains(date) ||
          _isDayPassed(
            index: index,
            r: r,
          )) {
        return true;
      }
      return false;
    }
  }

  void _onButtonTap() {
    widget._selectedIntervalNotifier.value =
        _calendarSelectedIntervalNotifier.value;
    Navigator.of(context).pop();
  }

  void _onDateCellTap(
      {required final index,
      required ({int month, int year, int startWeekday}) r}) {
    final DateTime date = _generateDateTime(
      index: index,
      r: r,
    );
    final DateTimeRange? currentDateRange =
        _calendarSelectedIntervalNotifier.value;
    if (currentDateRange != null) {
      if (currentDateRange.start.isAtSameMomentAs(date)) {
        _calendarSelectedIntervalNotifier.value = null;
      } else if (currentDateRange.end.isAtSameMomentAs(date)) {
        _calendarSelectedIntervalNotifier.value = DateTimeRange(
          start: date,
          end: date,
        );
      } else if (currentDateRange.start.isAfter(date)) {
        _calendarSelectedIntervalNotifier.value = DateTimeRange(
          start: date,
          end: _calendarSelectedIntervalNotifier.value!.end,
        );
      } else {
        _calendarSelectedIntervalNotifier.value = DateTimeRange(
          start: _calendarSelectedIntervalNotifier.value!.start,
          end: date,
        );
      }
    } else {
      _calendarSelectedIntervalNotifier.value = DateTimeRange(
        start: date,
        end: date,
      );
    }
  }

  BorderRadius? _getBorderRadius(
      {required int index,
      required ({int month, int year, int startWeekday}) r}) {
    final DateTime date = _generateDateTime(
      index: index,
      r: r,
    );
    final int daysInMonthCount =
        DateUtils.getDaysInMonth(date.year, date.month);
    if (date.weekday == 1) {
      if (date.day == daysInMonthCount) {
        return BorderRadius.circular(100);
      }
      return const BorderRadius.horizontal(
        left: Radius.circular(100),
      );
    }
    if (date.weekday == 7) {
      if (date.day == 1) {
        return BorderRadius.circular(100);
      }
      return const BorderRadius.horizontal(
        right: Radius.circular(100),
      );
    }
    if (date.day == 1) {
      return const BorderRadius.horizontal(
        left: Radius.circular(100),
      );
    }
    if (date.day == daysInMonthCount) {
      return const BorderRadius.horizontal(
        right: Radius.circular(100),
      );
    }
    return null;
  }

  bool _isPointOnEdge(
      {required int index, required DateTime date, required bool isStart}) {
    final int daysInMonthCount =
        DateUtils.getDaysInMonth(date.year, date.month);
    if (isStart) {
      if (date.day == daysInMonthCount || date.weekday == 7) {
        return true;
      }
      return false;
    } else {
      if (date.day == 1 || date.weekday == 1) {
        return true;
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _calendarSelectedIntervalNotifier,
      builder: (context, selectedInterval, _) => Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: monthCount,
                itemBuilder: (context, calendarIndex) {
                  int k = 0;
                  final ({
                    int month,
                    int year,
                    int startWeekday
                  }) monthAndYearAndStartWeekday =
                      _getMonthAndYearAndStartWeekday(
                    index: calendarIndex,
                  );
                  final int previousMonthDayCount = _getPreviousMonthDayCount(
                    year: monthAndYearAndStartWeekday.year,
                    month: monthAndYearAndStartWeekday.month,
                  );
                  _setLastPeviousMonthDays(
                    startWeekday: monthAndYearAndStartWeekday.startWeekday,
                    previousMonthDayCount: previousMonthDayCount,
                  );
                  final int currentMonthDayCount = DateUtils.getDaysInMonth(
                    monthAndYearAndStartWeekday.year,
                    monthAndYearAndStartWeekday.month,
                  );
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormatUtil.monthYear(
                            year: monthAndYearAndStartWeekday.year,
                            month: monthAndYearAndStartWeekday.month,
                          ),
                          style: kSFProDisplaySemiBold.copyWith(
                            color: kBlack,
                            fontSize: 18,
                          ),
                        ),
                        GridView.builder(
                          itemCount: 7 +
                              monthAndYearAndStartWeekday.startWeekday +
                              currentMonthDayCount,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 0,
                          ),
                          itemBuilder: (context, index) {
                            if (index < 7) {
                              return DefaultDay(
                                day: DateFormatUtil.ruWeekdayShort(
                                  dayNumber: index + 1,
                                ),
                              );
                            } else if (index > 6 &&
                                index <
                                    7 +
                                        monthAndYearAndStartWeekday
                                            .startWeekday) {
                              k++;
                              return UnavailableDay(
                                day: lastPeviousMonthDays.reversed
                                    .toList()[k - 1]
                                    .toString(),
                              );
                            } else if (_isDayUnavailable(
                                index: index, r: monthAndYearAndStartWeekday)) {
                              return UnavailableDay(
                                day: (index -
                                        6 -
                                        monthAndYearAndStartWeekday
                                            .startWeekday)
                                    .toString(),
                              );
                            } else {
                              return Center(
                                child: InkWell(
                                  onTap: () => _onDateCellTap(
                                      index: index,
                                      r: monthAndYearAndStartWeekday),
                                  child: switch (selectedInterval) {
                                    (DateTimeRange interval)
                                        when interval.start.isAtSameMomentAs(
                                          _generateDateTime(
                                              index: index,
                                              r: monthAndYearAndStartWeekday),
                                        ) =>
                                      MarkedDay(
                                        day: (index -
                                                6 -
                                                monthAndYearAndStartWeekday
                                                    .startWeekday)
                                            .toString(),
                                        isStart: true,
                                        isEqual: interval.start
                                            .isAtSameMomentAs(interval.end),
                                        isOnEdge: _isPointOnEdge(
                                            index: index,
                                            date: interval.start,
                                            isStart: true),
                                      ),
                                    (DateTimeRange range)
                                        when range.end.isAtSameMomentAs(
                                          _generateDateTime(
                                              index: index,
                                              r: monthAndYearAndStartWeekday),
                                        ) =>
                                      MarkedDay(
                                        day: (index -
                                                6 -
                                                monthAndYearAndStartWeekday
                                                    .startWeekday)
                                            .toString(),
                                        isStart: false,
                                        isEqual: range.start
                                            .isAtSameMomentAs(range.end),
                                        isOnEdge: _isPointOnEdge(
                                          index: index,
                                          date: range.end,
                                          isStart: false,
                                        ),
                                      ),
                                    (DateTimeRange range)
                                        when range.start.isBefore(_generateDateTime(
                                                index: index,
                                                r:
                                                    monthAndYearAndStartWeekday)) &&
                                            range.end.isAfter(_generateDateTime(
                                                index: index,
                                                r: monthAndYearAndStartWeekday)) =>
                                      IntervaledDay(
                                        day: (index -
                                                6 -
                                                monthAndYearAndStartWeekday
                                                    .startWeekday)
                                            .toString(),
                                        borderRadius: _getBorderRadius(
                                          index: index,
                                          r: monthAndYearAndStartWeekday,
                                        ),
                                      ),
                                    _ => DefaultDay(
                                        day: (index -
                                                6 -
                                                monthAndYearAndStartWeekday
                                                    .startWeekday)
                                            .toString(),
                                      ),
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            FadeAnimationYUp(
              delay: .1,
              child: BottomShadowContainer(
                left: selectedInterval != null &&
                        selectedInterval.start != selectedInterval.end
                    ? Text(
                        DateFormatUtil.dateRange(
                            interval: selectedInterval, withYear: true),
                        overflow: TextOverflow.visible,
                        style: kSFProDisplayMedium.copyWith(
                          fontSize: 16,
                          color: kBlack,
                        ),
                      )
                    : Text(
                        'Даты поездки',
                        overflow: TextOverflow.visible,
                        style: kSFProDisplayMedium.copyWith(
                          fontSize: 16,
                          color: kBlack50,
                        ),
                      ),
                right: RoundedTextButton(
                  isEnabled: selectedInterval != null &&
                      selectedInterval.start != selectedInterval.end,
                  text: 'Забронировать',
                  onTap: _onButtonTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
