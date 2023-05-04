import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendar.style.dart';

class Event {
  final DateTime date;
  Event({required this.date});
}

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  // CalendarController _calendarController = CalendarController();
  // Map<DateTime, List<EventsModel>> _events;
  DateTime _now = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

  final _events = LinkedHashMap(
    equals: isSameDay,
  )..addAll({
      DateTime(2022, 8, 4): Event(date: DateTime(2022, 8, 4)),
      DateTime(2022, 8, 6): Event(date: DateTime(2022, 8, 6)),
      DateTime(2022, 8, 7): Event(date: DateTime(2022, 8, 7)),
      DateTime(2022, 8, 9): Event(date: DateTime(2022, 8, 9)),
      DateTime(2022, 8, 11): Event(date: DateTime(2022, 8, 11)),
      DateTime(2022, 8, 14): Event(date: DateTime(2022, 8, 14)),
    });

  @override
  Widget build(BuildContext context) {
    Logger().w(DateTime.timestamp().microsecondsSinceEpoch);
    return TableCalendar(
      firstDay: DateTime(_now.year, _now.month, 1),
      lastDay: DateTime(_now.year, _now.month + 1, 0),
      focusedDay: _now,
      calendarFormat: _calendarFormat,
      daysOfWeekHeight: 30,
      headerVisible: false,
      calendarStyle: calendarStyle(context),
      selectedDayPredicate: (day) {
        // Use `selectedDayPredicate` to determine which day is currently selected.
        // If this returns true, then `day` will be marked as selected.

        // Using `isSameDay` is recommended to disregard
        // the time-part of compared DateTime objects.
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          // Call `setState()` when updating the selected day
          setState(() {
            _selectedDay = selectedDay;
            _now = focusedDay;
          });
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _now = focusedDay;
      },
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          return Center(child: Text(days[day.weekday]));
        },
        markerBuilder: (context, date, events) {
          DateTime date = DateTime(date.year, date.month, date.day);
          if (isSameDay(date, _events[date])) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.11,
              padding: const EdgeInsets.only(bottom: 5),
              decoration: const BoxDecoration(
                color: Colors.lightBlue,
                shape: BoxShape.circle,
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
