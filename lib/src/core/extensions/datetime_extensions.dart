extension OnDateTime on DateTime {
  String formattedDate({bool withYear = false}) {
    final daySuffixes = [
      'th',
      'st',
      'nd',
      'rd',
      'th',
      'th',
      'th',
      'th',
      'th',
      'th'
    ];
    final monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    final day = this.day;
    final month = this.month;
    final year = this.year;

    final daySuffix = (day % 100 >= 11 && day % 100 <= 13)
        ? 'th'
        : daySuffixes[(day % 10 < 1 || day % 10 > 3) ? 0 : day % 10];

    return withYear
        ? '$day$daySuffix ${monthNames[month - 1]}, $year'
        : '$day$daySuffix ${monthNames[month - 1]}';
  }

  String get to12HourFormat {
    int hour = this.hour;
    String period = 'am';
    if (hour >= 12) {
      period = 'pm';
      if (hour > 12) {
        hour -= 12;
      }
    } else if (hour == 0) {
      hour = 12;
    }

    String minute = this.minute.toString().padLeft(2, '0');

    return '$hour:$minute $period';
  }
}

/// DateTime(2023, 3, 2).formattedDate;   -->   2nd March, 2023
/// DateTime(2024, 1, 1).formattedDate;   -->   1st January
/// DateTime(2021, 11, 11).formattedDate; -->   11th November


