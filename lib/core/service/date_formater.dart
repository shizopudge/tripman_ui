enum DateUseCase {
  parent,
}

class DateFormater {
  final DateTime date;
  DateFormater({required this.date});

  String _ruMonth({required DateUseCase usecase}) {
    final month = date.month;
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

  String dMonthRuFormat({required DateUseCase usecase}) {
    final int day = date.day;
    final month = _ruMonth(usecase: usecase);
    return '$day $month';
  }
}
