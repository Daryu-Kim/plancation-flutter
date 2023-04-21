import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    final defaultBoxDeco = BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(6.0),
    );

    final defaultTextStyle = TextStyle(
      color: Colors.grey[600],
      fontWeight: FontWeight.w700,
    );

    return TableCalendar(
      locale: 'ko-KR',
      focusedDay: DateTime.now(),
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      headerStyle: const HeaderStyle(
        formatButtonVisible: true,

        // titleCentered: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
      ),
      // calendarStyle: CalendarStyle(
      //   isTodayHighlighted: false,
      //   outsideDecoration: BoxDecoration(shape: BoxShape.rectangle),
      //   defaultDecoration: defaultBoxDeco,
      //   weekendDecoration: defaultBoxDeco,
      //   selectedDecoration: BoxDecoration(
      //     color: Theme.of(context).colorScheme.primary,
      //     borderRadius: BorderRadius.circular(100),
      //     // border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1.0),
      //   ),
      //   defaultTextStyle: defaultTextStyle,
      //   weekendTextStyle: defaultTextStyle.copyWith(color: Theme.of(context).colorScheme.error),
      //   // selectedTextStyle: defaultTextStyle.copyWith(color: Theme.of(context).colorScheme.primary),
      // ),
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        setState(() {
          this.selectedDay = selectedDay;
        });
      },
      selectedDayPredicate: (DateTime date) {
        if (selectedDay == null) {
          return false;
        }

        return date.year == selectedDay!.year &&
            date.month == selectedDay!.month &&
            date.day == selectedDay!.day;
      },
    );
  }
}