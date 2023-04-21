import 'package:flutter/material.dart';
import '../components/calendar.dart';

class HomeCalendarComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Calendar(),
      ),
    );
  }
}