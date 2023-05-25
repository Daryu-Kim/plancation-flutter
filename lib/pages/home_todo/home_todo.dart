import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plancation/modules/another.dart';
import 'package:plancation/styles/body_style.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../components/event_list/todo_list.dart';
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

  void showBottomSheet() => showModalBottomSheet(
        context: context,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20.0),
        // ),
        builder: (context) => const TodoForm(),

        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(
        //   top: Radius.circular(25.0),
        // )),
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
        child: Container(
          height: setBodyHeightIncludeBNB(context),
          padding: BodyStyle().bodyPadding,
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
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    size: 24,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    size: 24,
                  ),
                  headerPadding: EdgeInsets.zero,
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

                  defaultTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),

                  //오늘날짜 데코
                  todayDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      color: Theme.of(context).colorScheme.tertiary),
                  todayTextStyle: const TextStyle(
                      color: Color.fromARGB(255, 255, 221, 117),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),

                  //선택한 날짜 데코
                  selectedDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      color: Theme.of(context).colorScheme.primary),

                  //해당월과 다른날짜들 데코
                  outsideDaysVisible: true,
                  outsideDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    color: Theme.of(context).colorScheme.tertiary,
                  ),

                  outsideTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),

                  //주말 데코
                  weekendDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  weekendTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
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
                    //날짜 요일 스타일링
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
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              //todo 리스트보여주기
              const TodoList(),
              const SizedBox(
                height: 18,
              ),
              const TodoList(),
            ],
          ),
        ),
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
}
