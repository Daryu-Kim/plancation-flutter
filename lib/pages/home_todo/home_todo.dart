import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../components/todo_new/todo_new.dart';

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
    setState(() {});
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
                  headerVisible: true,

                  //헤더부분
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                  ),

                  calendarStyle: CalendarStyle(
                    cellMargin: const EdgeInsets.symmetric(horizontal: 6),
                    cellPadding: EdgeInsets.zero,

                    //기본세팅
                    defaultDecoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        color: Theme.of(context).colorScheme.tertiary),

                    //오늘날짜 데코
                    todayDecoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        color: Theme.of(context).colorScheme.tertiary),

                    //선택한 날짜 데코
                    selectedDecoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        color: Theme.of(context).colorScheme.primary),
                  ),

                  //캘린더 요일부분
                  calendarBuilders: CalendarBuilders(
                    dowBuilder: (context, day) {
                      var text = DateFormat.E().format(day);

                      if (day.weekday == DateTime.sunday) {
                        text = '일';
                      } else if (day.weekday == DateTime.monday) {
                        text = '월';
                      } else if (day.weekday == DateTime.tuesday) {
                        text = '화';
                      } else if (day.weekday == DateTime.wednesday) {
                        text = '수';
                      } else if (day.weekday == DateTime.thursday) {
                        text = '목';
                      } else if (day.weekday == DateTime.friday) {
                        text = '금';
                      } else if (day.weekday == DateTime.saturday) {
                        text = '토';
                      }
                      return Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            )),
                        child: Text(
                          text,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                  // headerStyle: const HeaderStyle(
                  //   leftChevronIcon: Icon(
                  //     Icons.chevron_left,
                  //     size: 24,
                  //   ),
                  //   rightChevronIcon: Icon(
                  //     Icons.chevron_right,
                  //     size: 24,
                  //   ),
                  //   headerPadding: EdgeInsets.zero,
                  //   formatButtonVisible: true,
                  // ),
                  // calendarStyle: CalendarStyle(
                  //   outsideDecoration: BoxDecoration(color: Colors.red),
                  //   selectedDecoration: const BoxDecoration(
                  //     color: Colors.red,
                  //     shape: BoxShape.rectangle,
                  //   ),
                  //   selectedTextStyle: const TextStyle(
                  //       color: Color.fromRGBO(238, 230, 226, 1)),
                  //   todayDecoration: BoxDecoration(
                  //     color: Theme.of(context).colorScheme.tertiary,
                  //     shape: BoxShape.circle,
                  //   ),
                  // ),
                ),
              ],
            )),
      ),
      //플로팅버튼
      floatingActionButton: FloatingActionButton(
        heroTag: 'todo',
        onPressed: showBottomSheet,
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        child: const Text(
          '추가',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  void showBottomSheet() => showModalBottomSheet(
      context: context, builder: (context) => const TodoNew()
      // <Widget>[
      //   ListTile(
      //     leading: const Icon(Icons.share),
      //     onTap: () {},
      //   ),
      //   ListTile(
      //     leading: const Icon(Icons.link),
      //     onTap: () {},
      //   )
      // ],
      );
}
