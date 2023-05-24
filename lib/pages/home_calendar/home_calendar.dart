import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:plancation/pages/home_calendar/home_calendar.style.dart';
import 'package:table_calendar/table_calendar.dart';

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
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      iconSize: 36,
                      padding: const EdgeInsets.all(0),
                      icon: SvgPicture.asset(
                        'assets/svgs/menu_icon.svg',
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text('April', style: containerTitleTextStyle),
                      Text('2023'),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    iconSize: 36,
                    padding: const EdgeInsets.all(0),
                    icon: const Icon(Icons.account_circle),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 172,
              child: TableCalendar(
                firstDay: DateTime(
                    currentDateTime.year - 1, currentDateTime.month, 1),
                lastDay: DateTime(currentDateTime.year + 10, 12, 0),
                focusedDay: currentDateTime,
                headerVisible: false,
                calendarFormat: CalendarFormat.month,
                daysOfWeekHeight: 36,
                rowHeight: (MediaQuery.of(context).size.height - 172 - 36) / 6,
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
              onTap: () => Logger().d("할일 추가 클릭됨."),
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
