import 'package:flutter/material.dart';
import '../components/calendar.dart';

class HomeCalendarComponent extends StatelessWidget {
  const HomeCalendarComponent({super.key});

  void refresh() {
    print("Refresh!");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Calendar(),
    );
  }
}
