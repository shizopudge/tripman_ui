import 'package:flutter/material.dart';

import '../../animations/fade_animation_x.dart';
import '../../animations/fade_animation_y_up.dart';
import '../../service/date_formater.dart';
import '../../styles/styles.dart';
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
  late final ValueNotifier<DateTimeRange?> _calendarSelectedIntervalNotifier;
  late final int calendarFirstAvailableDay;
  final List<DateTime> pastDaysOfTheMonth = [];
  final List<int> lastPeviousMonthDays = [];
  final List<DateTime> availableDates = [];
  final DateTime now = DateTime.now();
  final int currentDay = DateTime.now().day;
  final int monthCount = 12;

  @override
  void initState() {
    _getPastDaysOfTheMonth();
    if (widget.availableRange != null) {
      _getAvailableDates(
        startDate: widget.availableRange!.start,
        endDate: widget.availableRange!.end,
      );
    }
    _calendarSelectedIntervalNotifier =
        ValueNotifier<DateTimeRange?>(widget._selectedIntervalNotifier.value);
    calendarFirstAvailableDay = DateTime(pastDaysOfTheMonth.last.year,
            pastDaysOfTheMonth.last.month, pastDaysOfTheMonth.last.day + 1)
        .day;
    super.initState();
  }

  @override
  void dispose() {
    _calendarSelectedIntervalNotifier.dispose();
    super.dispose();
  }

  void _getAvailableDates(
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

  void _getPastDaysOfTheMonth() {
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
      if (date.day == calendarFirstAvailableDay ||
          date.day == daysInMonthCount ||
          date.weekday == 7) {
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
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
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
                      FadeAnimationX(
                        delay: .6,
                        child: Text(
                          DateFormater.datePickerMonthYearFormater(
                            month: monthAndYearAndStartWeekday.month,
                            year: monthAndYearAndStartWeekday.year,
                          ),
                          style: kSFProDisplaySemiBold.copyWith(
                            color: kBlack,
                            fontSize: 18,
                          ),
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
                            return FadeAnimationX(
                              delay: .2 + index / 25,
                              child: Center(
                                child: Text(
                                  DateFormater.datePickerWeekdayFormater(
                                    dayNumber: index + 1,
                                  ),
                                  style: kSFProDisplayRegular.copyWith(
                                    color: kBlack,
                                    fontSize:
                                        MediaQuery.of(context).size.width /
                                            100 *
                                            3.2,
                                  ),
                                ),
                              ),
                            );
                          } else if (index > 6 &&
                              index <
                                  7 +
                                      monthAndYearAndStartWeekday
                                          .startWeekday) {
                            k++;
                            return FadeAnimationX(
                              delay: .2 + index / 25,
                              child: UnavailableDay(
                                day: lastPeviousMonthDays.reversed
                                    .toList()[k - 1]
                                    .toString(),
                              ),
                            );
                          } else if (_isDayUnavailable(
                              index: index, r: monthAndYearAndStartWeekday)) {
                            return FadeAnimationX(
                              delay: .2 + index / 25,
                              child: UnavailableDay(
                                day: (index -
                                        6 -
                                        monthAndYearAndStartWeekday
                                            .startWeekday)
                                    .toString(),
                              ),
                            );
                          } else {
                            return FadeAnimationX(
                              delay: .2 + index / 25,
                              child: Center(
                                child: InkWell(
                                  onTap: () => _onDateCellTap(
                                      index: index,
                                      r: monthAndYearAndStartWeekday),
                                  child: ValueListenableBuilder(
                                    valueListenable:
                                        _calendarSelectedIntervalNotifier,
                                    builder: (context, selectedDates, _) =>
                                        switch (selectedDates) {
                                      (DateTimeRange range)
                                          when range.start.isAtSameMomentAs(
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
                                          isEqual: range.start
                                              .isAtSameMomentAs(range.end),
                                          isOnEdge: _isPointOnEdge(
                                              index: index,
                                              date: range.start,
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
                                          when range.start.isBefore(
                                                  _generateDateTime(
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
                                ),
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
            delay: .8,
            child: ValueListenableBuilder(
              valueListenable: _calendarSelectedIntervalNotifier,
              builder: (context, selectedInterval, _) => BottomShadowContainer(
                left: Text(
                  DateFormater.datesFieldDateFormater(
                    interval: selectedInterval != null &&
                            selectedInterval.start != selectedInterval.end
                        ? selectedInterval
                        : null,
                  ),
                  overflow: TextOverflow.visible,
                  style: kSFProDisplayMedium.copyWith(
                    fontSize: 16,
                    color: selectedInterval != null &&
                            selectedInterval.start != selectedInterval.end
                        ? kBlack
                        : kBlack50,
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
          ),
        ],
      ),
    );
  }
}
