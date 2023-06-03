import 'package:flutter/material.dart';
import 'package:tripman/core/common_widgets/rounded_text_button.dart';

import '../../../../core/service/date_formater.dart';
import '../../../../core/styles/styles.dart';

class DatePickerBottomSheet extends StatelessWidget {
  final ValueNotifier<DateTimeRange?> _selectedDatesNotifier;
  const DatePickerBottomSheet({
    super.key,
    required ValueNotifier<DateTimeRange?> selectedDatesNotifier,
  }) : _selectedDatesNotifier = selectedDatesNotifier;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: .8,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 6,
            width: MediaQuery.of(context).size.width * .2,
            color: Colors.transparent,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: kWhite,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Даты поездки',
                      style: kSFProDisplaySemiBold.copyWith(
                        color: kBlack,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: Calendar(
                      selectedDatesNotifier: _selectedDatesNotifier,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Calendar extends StatefulWidget {
  final ValueNotifier<DateTimeRange?> _selectedDatesNotifier;
  const Calendar({
    super.key,
    required ValueNotifier<DateTimeRange?> selectedDatesNotifier,
  }) : _selectedDatesNotifier = selectedDatesNotifier;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final ValueNotifier<DateTimeRange?> _calendarSelectedDatesNotifier;
  final List<int> pastDaysOfTheMonth = [];
  final List<int> lastPeviousMonthDays = [];
  final int currentDay = DateTime.now().day;
  final int monthCount = 12;

  @override
  void initState() {
    _calendarSelectedDatesNotifier =
        ValueNotifier<DateTimeRange?>(widget._selectedDatesNotifier.value);
    for (int j = 0; j < currentDay; j++) {
      pastDaysOfTheMonth.add(j);
    }
    super.initState();
  }

  @override
  void dispose() {
    _calendarSelectedDatesNotifier.dispose();
    super.dispose();
  }

  ({int month, int year, int startWeekday}) _getMonthAndYearAndStartWeekday(
          {required int index}) =>
      (
        month:
            DateTime.now().copyWith(month: DateTime.now().month + index).month,
        year: DateTime.now().copyWith(month: DateTime.now().month + index).year,
        startWeekday: DateTime.now()
                .copyWith(month: DateTime.now().month + index, day: 1)
                .weekday -
            1,
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
          required int startWeekday,
          required int month}) =>
      pastDaysOfTheMonth.contains(index - 6 - startWeekday - 1) &&
      month == DateTime.now().month;

  void _onButtonTap() {
    widget._selectedDatesNotifier.value = _calendarSelectedDatesNotifier.value;
    Navigator.of(context).pop();
  }

  void _onDateCellTap(
      {required final index,
      required ({int month, int year, int startWeekday}) r}) {
    if (_calendarSelectedDatesNotifier.value != null) {
      if (_calendarSelectedDatesNotifier.value!.start.isAtSameMomentAs(
        _generateDateTime(index: index, r: r),
      )) {
        _calendarSelectedDatesNotifier.value = null;
      } else if (_calendarSelectedDatesNotifier.value!.start.isAfter(
        _generateDateTime(index: index, r: r),
      )) {
        _calendarSelectedDatesNotifier.value = DateTimeRange(
          start: _generateDateTime(index: index, r: r),
          end: _calendarSelectedDatesNotifier.value!.start,
        );
      } else {
        _calendarSelectedDatesNotifier.value = DateTimeRange(
          start: _calendarSelectedDatesNotifier.value!.start,
          end: _generateDateTime(index: index, r: r),
        );
      }
    } else {
      _calendarSelectedDatesNotifier.value = DateTimeRange(
        start: _generateDateTime(index: index, r: r),
        end: _generateDateTime(index: index, r: r),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: monthCount,
            itemBuilder: (context, calendarIndex) {
              int k = 0;
              final ({
                int month,
                int year,
                int startWeekday
              }) monthAndYearAndStartWeekday = _getMonthAndYearAndStartWeekday(
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
                      DateFormater.datePickerMonthYearFormater(
                        month: monthAndYearAndStartWeekday.month,
                        year: monthAndYearAndStartWeekday.year,
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
                      ),
                      itemBuilder: (context, index) {
                        if (index < 7) {
                          return Center(
                            child: Text(
                              DateFormater.datePickerWeekdayFormater(
                                dayNumber: index + 1,
                              ),
                              style: kSFProDisplayRegular.copyWith(
                                color: kBlack,
                                fontSize: MediaQuery.of(context).size.width /
                                    100 *
                                    3.2,
                              ),
                            ),
                          );
                        } else if (index > 6 &&
                            index <
                                7 + monthAndYearAndStartWeekday.startWeekday) {
                          k++;
                          return Center(
                            child: Text(
                              lastPeviousMonthDays.reversed
                                  .toList()[k - 1]
                                  .toString(),
                              style: kSFProDisplayRegular.copyWith(
                                color: kBlack.withOpacity(.2),
                                fontSize: MediaQuery.of(context).size.width /
                                    100 *
                                    3.2,
                              ),
                            ),
                          );
                        } else {
                          if (_isDayPassed(
                              index: index,
                              startWeekday:
                                  monthAndYearAndStartWeekday.startWeekday,
                              month: monthAndYearAndStartWeekday.month)) {
                            return Center(
                              child: Text(
                                (index -
                                        6 -
                                        monthAndYearAndStartWeekday
                                            .startWeekday)
                                    .toString(),
                                style: kSFProDisplayRegular.copyWith(
                                  color: kBlack.withOpacity(.2),
                                  fontSize: MediaQuery.of(context).size.width /
                                      100 *
                                      3.2,
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: InkWell(
                                onTap: () => _onDateCellTap(
                                    index: index,
                                    r: monthAndYearAndStartWeekday),
                                child: ValueListenableBuilder(
                                  valueListenable:
                                      _calendarSelectedDatesNotifier,
                                  builder: (context, selectedDates, _) =>
                                      switch (selectedDates) {
                                    (DateTimeRange range)
                                        when range.start.isAtSameMomentAs(
                                          _generateDateTime(
                                              index: index,
                                              r: monthAndYearAndStartWeekday),
                                        ) =>
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 15),
                                            decoration: const BoxDecoration(
                                              color: kBlack10,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                left: Radius.circular(100),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 15),
                                            height: double.maxFinite,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: kBlack,
                                            ),
                                            child: Center(
                                              child: Text(
                                                (index -
                                                        6 -
                                                        monthAndYearAndStartWeekday
                                                            .startWeekday)
                                                    .toString(),
                                                style: kSFProDisplayRegular
                                                    .copyWith(
                                                  color: kWhite,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          100 *
                                                          3.2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    (DateTimeRange range)
                                        when range.end.isAtSameMomentAs(
                                          _generateDateTime(
                                              index: index,
                                              r: monthAndYearAndStartWeekday),
                                        ) =>
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 15),
                                            decoration: const BoxDecoration(
                                              color: kBlack10,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                right: Radius.circular(100),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 15),
                                            height: double.maxFinite,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: kBlack,
                                            ),
                                            child: Center(
                                              child: Text(
                                                (index -
                                                        6 -
                                                        monthAndYearAndStartWeekday
                                                            .startWeekday)
                                                    .toString(),
                                                style: kSFProDisplayRegular
                                                    .copyWith(
                                                  color: kWhite,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          100 *
                                                          3.2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    (DateTimeRange range)
                                        when range.start.isBefore(_generateDateTime(
                                                index: index,
                                                r:
                                                    monthAndYearAndStartWeekday)) &&
                                            range.end.isAfter(_generateDateTime(
                                                index: index,
                                                r: monthAndYearAndStartWeekday)) =>
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 15),
                                            decoration: BoxDecoration(
                                              color: kBlack10,
                                              borderRadius: _generateDateTime(
                                                              index: index,
                                                              r:
                                                                  monthAndYearAndStartWeekday)
                                                          .weekday ==
                                                      1
                                                  ? const BorderRadius
                                                      .horizontal(
                                                      left:
                                                          Radius.circular(100),
                                                    )
                                                  : _generateDateTime(
                                                                  index: index,
                                                                  r:
                                                                      monthAndYearAndStartWeekday)
                                                              .weekday ==
                                                          7
                                                      ? const BorderRadius
                                                          .horizontal(
                                                          right:
                                                              Radius.circular(
                                                                  100),
                                                        )
                                                      : null,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 15),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: kBlack10,
                                            ),
                                            child: Text(
                                              (index -
                                                      6 -
                                                      monthAndYearAndStartWeekday
                                                          .startWeekday)
                                                  .toString(),
                                              style:
                                                  kSFProDisplayRegular.copyWith(
                                                color: kBlack,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    100 *
                                                    3.2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    _ => Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 7, horizontal: 15),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          (index -
                                                  6 -
                                                  monthAndYearAndStartWeekday
                                                      .startWeekday)
                                              .toString(),
                                          style: kSFProDisplayRegular.copyWith(
                                            color: kBlack,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                100 *
                                                3.2,
                                          ),
                                        ),
                                      ),
                                  },
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: kWhite,
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                color: kBlack10,
                offset: Offset(
                  2,
                  -4,
                ),
              ),
            ],
          ),
          child: ValueListenableBuilder(
            valueListenable: _calendarSelectedDatesNotifier,
            builder: (context, selectedDates, _) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: Text(
                      DateFormater.datesFieldDateFormater(
                        interval: selectedDates,
                      ),
                      overflow: TextOverflow.visible,
                      style: kSFProDisplayMedium.copyWith(
                        fontSize: 16,
                        color: selectedDates != null ? kBlack : kBlack50,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Flexible(
                    flex: 3,
                    child: RoundedTextButton(
                      backgroundColor:
                          selectedDates != null ? kBlack : kBlack10,
                      textColor: selectedDates != null ? kWhite : kBlack50,
                      text: 'Забронировать',
                      onTap: selectedDates != null ? _onButtonTap : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
