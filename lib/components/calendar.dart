import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  // CalendarController _calendarController = CalendarController();
  // Map<DateTime, List<EventsModel>> _events;
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    void _onDaySelected(DateTime day, List e) {
      setState(() {
        _selectedDay = day;
        // e.isEmpty ? _selectedEvents = [] : _selectedEvents = e;
      });
    }

    CalendarBuilders calendarBuilders() {
      return CalendarBuilders(
        holidayBuilder: (context, date, _) {
          return
        }
      );
    }

    return TableCalendar(
        locale: 'ko-KR',
        focusedDay: DateTime.now(),
        firstDay: DateTime(1800),
        lastDay: DateTime(3000),

        // headerVisible: false,
      availableGestures: AvailableGestures.all,
      // onDaySelected: _onDaySelected,

    );
  }
}
