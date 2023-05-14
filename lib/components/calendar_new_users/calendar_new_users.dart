import 'package:flutter/material.dart';

class CalendarNewUsers extends StatefulWidget {
  const CalendarNewUsers({super.key});

  @override
  _CalendarNewUsersState createState() => _CalendarNewUsersState();
}

class _CalendarNewUsersState extends State<CalendarNewUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: AlignmentDirectional.center,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 42, vertical: 28),
        ),
      ),
    );
  }
}
