import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:plancation/pages/home_calendar/home_calendar.style.dart';
import '../../components/calendar/calendar.dart';

class HomeCalendarComponent extends StatelessWidget {
  const HomeCalendarComponent({super.key});

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
                      children: [
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
        body: Container(
          height: MediaQuery.of(context).size.height - 172,
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 16),
          child: const Calendar(),
        ),
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
