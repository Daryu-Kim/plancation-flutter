import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../components/calendar.dart';

class HomeCalendarComponent extends StatelessWidget {
  const HomeCalendarComponent({super.key});

  void refresh() {
    print("Refresh!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Calendar(),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Logger().d("Add!"),
          child: Icon(Icons.add, color: Theme.of(context).colorScheme.inversePrimary),
        shape: CircleBorder(side: BorderSide(color: Theme.of(context).colorScheme.primary)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
