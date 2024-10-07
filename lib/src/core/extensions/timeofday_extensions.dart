// import 'package:flutter/material.dart';

// extension OnTimeOfDay on TimeOfDay {
//   String get timeFormat {
//     int hour = hourOfPeriod;
//     String period = this.period == DayPeriod.am ? 'AM' : 'PM';
//     String minute = this.minute.toString().padLeft(2, '0');
//     return '$hour:$minute $period';
//   }
// }
// updated
import 'package:flutter/material.dart';

extension OnTimeOfDay on TimeOfDay {
  String get timeFormat {
    int hour = hourOfPeriod == 0
        ? 12
        : hourOfPeriod; // Convert 0 hour to 12 for 12 AM/PM
    String period = this.period == DayPeriod.am ? 'AM' : 'PM';
    String minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  String get time24hFormat {
    String hour = this.hour.toString().padLeft(2, '0');
    String minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static String formatTo12Hour(String time) {
    final parts = time.split(':');
    if (parts.length != 2) {
      return time; // Return original if format is incorrect
    }
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour; // Convert 0 (midnight) to 12
    return '$hour:${minute.toString().padLeft(2, '0')} $period';
  }
}

TimeOfDay parseTimeOfDay(String time) {
  final parts = time.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}

String formatJsonTime(String jsonTime) {
  final timeOfDay = parseTimeOfDay(jsonTime);
  return timeOfDay.timeFormat;
}


//current
// import 'package:flutter/material.dart';

// extension OnTimeOfDay on TimeOfDay {
//   String get timeFormat24Hour {
//     String hour = this.hour.toString().padLeft(2, '0');
//     String minute = this.minute.toString().padLeft(2, '0');
//     return '$hour:$minute:00';
//   }
// }

// TimeOfDay parseTimeOfDay(String time) {
//   final parts = time.split(':');
//   final hour = int.parse(parts[0]);
//   final minute = int.parse(parts[1]);
//   return TimeOfDay(hour: hour, minute: minute);
// }

// String formatJsonTime(String jsonTime) {
//   final timeOfDay = parseTimeOfDay(jsonTime);
//   return timeOfDay.timeFormat24Hour;
// }
