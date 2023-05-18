import 'package:flutter/material.dart';

class MonthPicker extends StatefulWidget {
  const MonthPicker(
      {super.key,
        required this.diaryData,
        required this.authorName,
        required this.authorImagePath,
        required this.calendarUsersCount});

  final dynamic diaryData, authorName, authorImagePath, calendarUsersCount;

  @override
  MonthPickerState createState() => MonthPickerState();
}

class MonthPickerState extends State<MonthPicker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}