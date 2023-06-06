import 'package:flutter/material.dart';

enum DateKind {
  parent,
  basic,
}

class DateFormatUtil {
  static String ruWeekdayShort({required int dayNumber}) {
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

  static String _ruMonth({
    required DateKind dateKind,
    required int month,
  }) {
    late final String ruMonth;
    if (dateKind == DateKind.parent) {
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

  static String monthYear({
    required int year,
    required int month,
  }) =>
      '${_ruMonth(dateKind: DateKind.basic, month: month)} $year';

  static String dateRange({
    DateKind dateKind = DateKind.parent,
    required DateTimeRange interval,
    bool dublicateSameMonth = false,
    bool withYear = false,
    String spacer = '',
  }) {
    String intervalString = '';
    final startDate = interval.start;
    final endDate = interval.end;
    if (dateKind == DateKind.parent) {
      if (dublicateSameMonth == false) {
        if (startDate.month == endDate.month) {
          intervalString =
              '${startDate.day}$spacer-$spacer${endDate.day} ${_ruMonth(dateKind: dateKind, month: startDate.month)}';
        } else {
          intervalString =
              '${startDate.day} ${_ruMonth(dateKind: dateKind, month: startDate.month)}$spacer-$spacer${endDate.day} ${_ruMonth(dateKind: dateKind, month: endDate.month)}';
        }
      } else {
        intervalString =
            '${startDate.day} ${_ruMonth(dateKind: dateKind, month: startDate.month)}$spacer-$spacer${endDate.day} ${_ruMonth(dateKind: dateKind, month: endDate.month)}';
      }
      if (withYear) {
        if (startDate.year == endDate.year) {
          intervalString += ' ${startDate.year}';
        } else {
          intervalString += ' ${startDate.year}$spacer-$spacer${endDate.year}';
        }
      }
    }
    return intervalString;
  }
}
