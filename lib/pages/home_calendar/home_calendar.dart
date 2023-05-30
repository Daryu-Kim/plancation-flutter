import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:plancation/components/todo_new/todo_new.dart';
import 'package:plancation/pages/home_calendar/home_calendar.style.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../modules/another.dart';
import '../../styles/body_style.dart';

class HomeCalendarComponent extends StatefulWidget {
  const HomeCalendarComponent({super.key});

  @override
  HomeCalendarState createState() => HomeCalendarState();
}

class HomeCalendarState extends State<HomeCalendarComponent> {
  DateTime currentDateTime = DateTime.now();
  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];
  List calendarEvents = ["asdf", "ad", "qwer", "zxcv"];

  void refresh() {
    print("Refresh!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
              height: 60,
              color: Theme.of(context).colorScheme.secondary,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 28,
                          height: 28,
                          alignment: AlignmentDirectional.center,
                          child: SvgPicture.asset(
                            'assets/svgs/menu_icon.svg',
                            width: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "내 캘린더",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 14),
                            ),
                          ),
                          RichText(
                              text: TextSpan(
                                  text: "2023 April",
                                  style: containerTitleTextStyle))
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 28,
                          height: 28,
                          alignment: AlignmentDirectional.center,
                          child: SvgPicture.asset(
                            'assets/svgs/search_icon.svg',
                            width: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 28,
                          height: 28,
                          alignment: AlignmentDirectional.center,
                          child: SvgPicture.asset(
                            'assets/svgs/alert_icon.svg',
                            width: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          height: setBodyHeightIncludeBNB(context),
          padding: BodyStyle().bodyPadding,
          child: TableCalendar(
            firstDay:
                DateTime(currentDateTime.year - 1, currentDateTime.month, 1),
            lastDay: DateTime(currentDateTime.year + 10, 12, 0),
            focusedDay: currentDateTime,
            headerVisible: false,
            calendarFormat: CalendarFormat.month,
            daysOfWeekHeight: 36,
            rowHeight: setBodyHeightIncludeBNB(context) / 7,
            calendarStyle: CalendarStyleSheet().calendarStyle(context),
            availableGestures: AvailableGestures.horizontalSwipe,
            onDaySelected: (selectedDay, focusedDay) {
              Logger().e(selectedDay);
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (day.weekday == DateTime.sunday) {
                  return Center(
                    child: Text(day.day.toString(),
                        style: CalendarStyleSheet().sundayTextStyle),
                  );
                } else if (day.weekday == DateTime.saturday) {
                  return Center(
                    child: Text(day.day.toString(),
                        style: CalendarStyleSheet().saturdayTextStyle),
                  );
                } else {
                  return Center(
                    child: Text(day.day.toString(),
                        style: CalendarStyleSheet().defaultTextStyle),
                  );
                }
              },
              dowBuilder: (context, day) {
                if (day.weekday == DateTime.sunday) {
                  return Center(
                    child: Text(days[day.weekday],
                        style: CalendarStyleSheet().sundayTextStyle),
                  );
                } else if (day.weekday == DateTime.saturday) {
                  return Center(
                    child: Text(days[day.weekday],
                        style: CalendarStyleSheet().saturdayTextStyle),
                  );
                } else {
                  return Center(
                    child: Text(days[day.weekday],
                        style: CalendarStyleSheet().defaultTextStyle),
                  );
                }
              },
            ),
          ),
        )),
        floatingActionButton: SpeedDial(
          backgroundColor: Theme.of(context).colorScheme.primary,
          activeChild: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.surface,
          ),
          spacing: 20,
          onOpen: () => Logger().d("열림"),
          onClose: () => Logger().d("닫힘"),
          children: [
            SpeedDialChild(
              shape: const CircleBorder(),
              label: "  할일 추가  ",
              labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              labelBackgroundColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: CupertinoColors.white,
              child: SvgPicture.asset(
                'assets/svgs/todo_add.svg',
                color: Theme.of(context).colorScheme.surface,
              ),
              onTap: () => showModalBottomSheet(
                  context: context, builder: (context) => const TodoForm()),
            ),
            SpeedDialChild(
              shape: const CircleBorder(),
              label: "  일정 추가  ",
              labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              labelBackgroundColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: CupertinoColors.white,
              child: SvgPicture.asset(
                'assets/svgs/calendar_add.svg',
                color: Theme.of(context).colorScheme.surface,
              ),
              onTap: () => Logger().d("일정 추가 클릭됨."),
            ),
          ],
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.surface,
          ),
        ));
  }
}
