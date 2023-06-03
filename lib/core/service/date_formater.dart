import 'package:flutter/material.dart';

enum DateUseCase {
  parent,
  basic,
}

class DateFormater {
  static String _ruWeekdayShort({required int dayNumber}) {
    return switch (dayNumber) {
      1 => 'пн',
      2 => 'вт',
      3 => 'ср',
      4 => 'чт',
      5 => 'пт',
      6 => 'сб',
      7 => 'вс',
      _ => 'undefined',
    };
  }

  static String _ruMonth({required DateUseCase usecase, required int month}) {
    late final String ruMonth;
    if (usecase == DateUseCase.parent) {
      ruMonth = switch (month) {
        1 => 'января',
        2 => 'февраля',
        3 => 'марта',
        4 => 'Апреля',
        5 => 'мая',
        6 => 'июня',
        7 => 'июля',
        8 => 'августа',
        9 => 'сентября',
        10 => 'октября',
        11 => 'ноября',
        12 => 'декабря',
        _ => 'undefined',
      };
      return ruMonth;
    } else {
      ruMonth = switch (month) {
        1 => 'Январь',
        2 => 'Февраль',
        3 => 'Март',
        4 => 'Апрель',
        5 => 'Май',
        6 => 'Июнь',
        7 => 'Июль',
        8 => 'Август',
        9 => 'Сентябрь',
        10 => 'Октябрь',
        11 => 'Ноябрь',
        12 => 'Декабрь',
        _ => 'undefined',
      };
      return ruMonth;
    }
  }

  static String _dMonthRuFormat(
      {required DateUseCase usecase, required DateTime date}) {
    final int day = date.day;
    final String month = _ruMonth(usecase: usecase, month: date.month);
    return '$day $month';
  }

  static String tripCardDateFormater({
    required DateTimeRange interval,
  }) {
    return '${_dMonthRuFormat(usecase: DateUseCase.parent, date: interval.start)} - ${_dMonthRuFormat(
      usecase: DateUseCase.parent,
      date: interval.end,
    )}';
  }

  static String datesFieldDateFormater({
    required DateTimeRange? interval,
  }) {
    if (interval != null) {
      final (int firstDateYear, int secondDateYear) dateYears =
          (interval.start.year, interval.end.year);
      if (dateYears.$1 == dateYears.$2) {
        return '${_dMonthRuFormat(usecase: DateUseCase.parent, date: interval.start)} - ${_dMonthRuFormat(
          usecase: DateUseCase.parent,
          date: interval.end,
        )} ${dateYears.$1}';
      } else {
        return '${_dMonthRuFormat(usecase: DateUseCase.parent, date: interval.start)} - ${_dMonthRuFormat(
          usecase: DateUseCase.parent,
          date: interval.end,
        )} ${dateYears.$1}-${dateYears.$2}';
      }
    } else {
      return 'Даты поездки';
    }
  }

  static String datePickerMonthYearFormater(
      {required int month, required int year}) {
    final ruMonth = _ruMonth(usecase: DateUseCase.basic, month: month);
    return '$ruMonth $year';
  }

  static String datePickerWeekdayFormater({required int dayNumber}) {
    return _ruWeekdayShort(dayNumber: dayNumber);
  }
}
