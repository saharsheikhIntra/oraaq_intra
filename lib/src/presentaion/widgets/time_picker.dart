import 'package:flutter/material.dart';
import 'package:oraaq/src/config/themes/color_theme.dart';
import 'package:oraaq/src/core/extensions/timeofday_extensions.dart';

Future<void> selectTime(BuildContext context,
    Function(String time12h, String time24h) onSelectedTime) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          timePickerTheme: TimePickerThemeData(
            backgroundColor: ColorTheme.white, // Background color
            hourMinuteTextColor:
                ColorTheme.primaryText, // Text color for hours and minutes
            dayPeriodTextColor: ColorTheme.primaryText, // Text color for AM/PM
            dayPeriodBorderSide: const BorderSide(
                color: ColorTheme.black), // Border color for AM/PM
            dialHandColor: const Color(0xFF39608F), // Color of the hour hand

            dialTextColor:
                ColorTheme.primaryText, // Text color on the clock dial
            dialBackgroundColor: const Color(0xFFE1E2E8),

            entryModeIconColor: ColorTheme.primaryText,
            helpTextStyle: const TextStyle(
              color:
                  ColorTheme.onPrimary, // Set the text color for "Enter time"
            ),
            cancelButtonStyle: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(ColorTheme.onPrimary)),
            confirmButtonStyle: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(ColorTheme.onPrimary)),
          ),
          colorScheme: ColorScheme(
            primary: ColorTheme.primary.shade100,
            secondary: ColorTheme.secondary.shade200,
            background: ColorTheme.white,
            surface: const Color(0xFFE1E2E8),
            onBackground: Colors.white,
            onSurface: ColorTheme.white,
            onError: ColorTheme.white,
            onPrimary: ColorTheme.white,
            onSecondary: ColorTheme.white,
            brightness: Brightness.dark,
            error: Colors.red,
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    String formattedTime12h = picked.timeFormat; // Display format
    String formattedTime24h = picked.time24hFormat;
    onSelectedTime(formattedTime12h, formattedTime24h);
  }
}
