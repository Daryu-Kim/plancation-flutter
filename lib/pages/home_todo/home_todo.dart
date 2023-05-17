import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plancation/pages/home_todo/home_todo.style.dart';

class HomeTodoPage extends StatefulWidget {
  const HomeTodoPage({super.key});

  @override
  _HomeTodoPageState createState() => _HomeTodoPageState();
}

class _HomeTodoPageState extends State<HomeTodoPage> {
  @override
  void initState() {
    super.initState();
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
          alignment: AlignmentDirectional.center,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: const CalendarScreen(),
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     CalendarStrip(
          //       startDate: startDate,
          //       endDate: endDate,
          //       onDateSelected: onSelect,
          //       dateTileBuilder: dateTileBuilder,
          //       iconColor: Colors.black87,
          //       monthNameWidget: _monthNameWidget,
          //       markedDates: markedDates,
          //       containerDecoration: const BoxDecoration(color: Colors.black12),
          //     )
          //   ],
          // ),
        ),
      ),
    );
  }
}
