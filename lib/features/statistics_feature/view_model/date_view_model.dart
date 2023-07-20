import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateViewModel {
  // ? Variables
  List<String> listDate = [];
  List<int> listMonth = [];

  // ? Day
  String months(String? locale) {
    DateTime now = DateTime.now();
    final dateFormat = DateFormat("MMMM", locale);

    String month = dateFormat.format(now);

    return '$month ${now.year}'.toUpperCase();
  }

  // ? Week
  String weekOfTheMonth(String? locale) {
    DateTime now = DateTime.now();

    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    final dateFormat = DateFormat("MMM d", locale);

    String newDateNow = dateFormat.format(startOfWeek);
    String newDateWeek = dateFormat.format(endOfWeek);

    String week = '$newDateNow - $newDateWeek, ${now.year}'.toUpperCase();

    return week;
  }

  int retrieveUserSection(int index, List<String> finishedSection) {
    List<String> weekDates = listDate.toSet().toList();
    List<String> finishedDates =
        finishedSection.map((section) => section.split(' ')[1]).toList();

    if (_isLoopStopped(index, weekDates, finishedDates)) {
      return 0;
    }

    return _containsSameDate(index, weekDates, finishedSection);
  }

  Color getTextColorForDay(int index, String? locale) {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('EEE', locale);

    String dateNowFormat = dateFormat.format(now);
    String nowFormatted = dateNowFormat[0].toUpperCase() +
        dateNowFormat.substring(1).toLowerCase();

    String dayOfTheWeek = daysOfTheWeek(index, locale);

    Color textColor =
        dayOfTheWeek != nowFormatted ? Colors.white70 : Colors.white;

    return textColor;
  }

  String daysOfTheWeek(int i, String? locale) {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('EEE', locale);
    DateFormat yearFormat = DateFormat('y-MM-dd', locale);

    DateTime firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));

    List<String> weekDates = [];

    DateTime date = firstDayOfWeek.add(Duration(days: i));
    final formattedDate = dateFormat.format(date);
    final formattedYear = yearFormat.format(date);
    listDate.add(formattedYear);
    weekDates.add(
      formattedDate[0].toUpperCase() + formattedDate.substring(1).toLowerCase(),
    );

    return weekDates[0];
  }

  // ? Month
  String monthsOfTheYear(int i, String locale) {
    DateTime now = DateTime.now();

    List<String> upcomingMonths = [];
    DateTime nextMonth = DateTime(now.year, now.month + i, 1);
    String formatMonth = DateFormat('MMM', locale).format(nextMonth);
    upcomingMonths.add(formatMonth);
    listMonth.add(int.parse(DateFormat('M', locale).format(nextMonth)));

    return upcomingMonths[0][0].toUpperCase() +
        upcomingMonths[0].substring(1).toLowerCase();
  }

  Color getTextColorForMonth(int index, String locale) {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('MMM', locale);

    String dateNowFormat = dateFormat.format(now);
    String nowFormatted = dateNowFormat[0].toUpperCase() +
        dateNowFormat.substring(1).toLowerCase();

    String dayOfTheWeek = monthsOfTheYear(index, locale);

    Color textColor =
        dayOfTheWeek != nowFormatted ? Colors.white70 : Colors.white;

    return textColor;
  }
  int retrieveMonthsSection(int index, List<String> finishedSection) {
    List<String> finishedDates =
        finishedSection.map((section) => section.split(' ')[1]).toList();

    int totalUserSection = 0;
    String formattedMonth =
        listMonth.toSet().toList()[index].toString().padLeft(2, '0');

    for (String section in finishedSection) {
      if (section.contains('-$formattedMonth-') &&
          finishedDates.contains(section.split(' ')[1])) {
        totalUserSection += int.parse(section.split(' ')[0]);
      }
    }

    return totalUserSection;
  }

  // ? Helper Methods
  bool _isLoopStopped(
    int index,
    List<String> weekDates,
    List<String> finishedDates,
  ) {
    if (weekDates.length <= index ||
        !finishedDates.contains(weekDates[index])) {
      return true;
    }

    return false;
  }

  int _containsSameDate(
      int index, List<String> weekDates, List<String> finishedSection) {
    String selectedDate = weekDates[index];
    for (String section in finishedSection) {
      if (section.contains(selectedDate)) {
        return int.parse(section.split(' ')[0]);
      }
    }

    return 0;
  }
}
