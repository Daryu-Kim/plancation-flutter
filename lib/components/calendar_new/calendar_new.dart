import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'calendar_new.style.dart';

class CalendarNew extends StatefulWidget {
  const CalendarNew({super.key});

  @override
  _CalendarNewState createState() => _CalendarNewState();
}

class _CalendarNewState extends State<CalendarNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 28),
        ),
      ),
    );
  }
}
