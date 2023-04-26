import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home.style.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72),
        child:
          Container(
            height: 72,
            child:
              CupertinoNavigationBar(
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                middle: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: (){},
                          iconSize: 36,
                          padding: EdgeInsets.all(0),
                          icon: SvgPicture.asset(
                            'assets/svgs/menu_icon.svg',
                          )
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('April', style: containerTitleTextStyle),
                          Text('2023'),
                        ],
                      ),
                      IconButton(
                          onPressed: (){},
                        iconSize: 36,
                        padding: EdgeInsets.all(0),
                          icon: Icon(Icons.account_circle),
                      ),
                    ],
                  ),
              ),
          ),
      ),
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
