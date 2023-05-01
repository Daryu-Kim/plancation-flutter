import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:plancation/modules/firebase_login.dart';
import 'package:plancation/pages/home_my/home_my.dart';
import 'package:table_calendar/table_calendar.dart';
import 'home.style.dart';
import 'home_calendar/home_calendar.dart';

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
    HomeMyComponent(),
  ];

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      Logger().d(AuthManage().getUser());
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: body_item.elementAt(current_index),
      ),
      bottomNavigationBar: SizedBox(
        height: 72,
        child:
          BottomNavigationBar(
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
      ),
    );
  }
}
