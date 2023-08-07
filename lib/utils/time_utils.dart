import 'package:flutter/material.dart';

class DateTimeUtils {
  static Future<Map<String, String?>> getDateTime(
      {required BuildContext context}) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2950),
    ).then((date) {
      return showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      ).then((time1) {
        return showTimePicker(
          context: context,
          initialTime: time1!,
        ).then((time2) {
          return {
            "day": date?.toIso8601String(),
            "date": formatDate(date.toString()),
            "firstTime": time1.format(context),
            "secondTime": time2?.format(context),
          };
        }).onError((error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Time is not selected!")));
          return {};
        });
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Time is not selected!")));
        return {};
      });
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Time isn't selected!")));
      return {};
    });
  }
}

String formatDate(String dateString) {
  DateTime date = DateTime.parse(dateString);
  return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}

String formatDateForUI(String dateString) {
  DateTime date = DateTime.parse(dateString);
  return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
}

extension DateTimeExt on DateTime {
  DateTime get monthStart => DateTime(year, month);
  DateTime get dayStart => DateTime(year, month, day);

  DateTime addMonth(int count) {
    return DateTime(year, month + count, day);
  }

  bool isSameDate(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  bool get isToday {
    return isSameDate(DateTime.now());
  }
}
