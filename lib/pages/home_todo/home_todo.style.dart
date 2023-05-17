import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

var now = DateTime.now();
var firstDay = DateTime(now.year, now.month - 3, now.day);
var lastDay = DateTime(now.year, now.month + 3, now.day);

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
// 일주일 단위로 보게하기
  CalendarFormat format = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: now,
          firstDay: firstDay,
          lastDay: lastDay,
          calendarFormat: format,
          // 시작요일은 월요일
          startingDayOfWeek: StartingDayOfWeek.monday,

          headerStyle: const HeaderStyle(
            leftChevronIcon: Icon(
              Icons.chevron_left,
              size: 24,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              size: 24,
            ),
            headerPadding: EdgeInsets.zero,
            formatButtonVisible: true,
          ),
          calendarStyle: CalendarStyle(
            selectedDecoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.rectangle,
            ),
            selectedTextStyle:
                const TextStyle(color: Color.fromRGBO(238, 230, 226, 1)),
            todayDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
