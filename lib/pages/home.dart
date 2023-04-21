import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "home_calendar.dart";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current_index = 0;
  List body_item = [
    HomeCalendarComponent(),
    Text("할 일"),
    Text("AI"),
    Text("다이어리"),
    Text("MY"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 24,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {},
            ),
            Title(
              color: Theme.of(context).colorScheme.primary,
              child: Text(
                '개인',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Pretendard',
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                        onPressed: () {
                          Get.isDarkMode
                              ? Get.changeTheme(ThemeData.light())
                              : Get.changeTheme(ThemeData.dark());
                        },
                        icon: Icon(
                          Icons.search,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications,
                          color: Theme.of(context).colorScheme.primary,
                        )),
              ],
            )
          ],
        )
      ),
      body: Center(
        child: body_item.elementAt(current_index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 28,
        selectedLabelStyle:
            TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
        unselectedLabelStyle:
            TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.inversePrimary,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        //현재 index 변수에 저장
        currentIndex: current_index,
        //tap -> index 변경
        onTap: (index) {
          print('index test : ${index}');
          setState(() {
            current_index = index;
          });
        },
        //BottomNavi item list
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: '캘린더',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: '할 일',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.laptop),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: '다이어리',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'MY',
          ),
        ],
      ),
    );
  }
}
