import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

DateTime now = DateTime.now();

class HomeTodoPage extends StatefulWidget {
  const HomeTodoPage({super.key});

  @override
  _HomeTodoPageState createState() => _HomeTodoPageState();
}

class _HomeTodoPageState extends State<HomeTodoPage> {
  DateTime firstDay = DateTime(now.year, now.month - 3, now.day);
  DateTime lastDay = DateTime(now.year, now.month + 3, now.day);

  @override
  void initState() {
    super.initState();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SafeArea(
          child: Container(
            color: Theme.of(context).colorScheme.secondary,
            height: 60,
            child: const Center(
              child: Text(
                '할 일 목록',
                style: TextStyle(
                  fontSize: 18,
                  color: CupertinoColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 172,
          child: Column(
            children: [
              TableCalendar(
                focusedDay: now,
                firstDay: firstDay,
                lastDay: lastDay,
                calendarFormat: CalendarFormat.week,
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
          )
        ),
      ),
    );
  }
}
