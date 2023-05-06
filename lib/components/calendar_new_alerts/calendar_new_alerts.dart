import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'calendar_new_alerts.style.dart';

class CalendarNewAlerts extends StatefulWidget {
  const CalendarNewAlerts({super.key});

  @override
  _CalendarNewAlertsState createState() => _CalendarNewAlertsState();
}

class _CalendarNewAlertsState extends State<CalendarNewAlerts> {
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
