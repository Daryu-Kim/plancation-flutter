import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:numberpicker/numberpicker.dart';
import 'package:calendar_strip/calendar_strip.dart';

class HomeTodoPage extends StatefulWidget {
  const HomeTodoPage({super.key});

  @override
  _HomeTodoPageState createState() => _HomeTodoPageState();
}

class _HomeTodoPageState extends State<HomeTodoPage> {
  int currentValue = 3;
  DateTime startDate = DateTime.now().subtract(const Duration(days: 2));
  DateTime endDate = DateTime.now().add(const Duration(days: 2));
  DateTime selectedDate = DateTime.now().subtract(const Duration(days: 2));
  List<DateTime> markedDates = [
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.now().subtract(const Duration(days: 2)),
    DateTime.now().add(const Duration(days: 4))
  ];

  onSelect(data) {
    print("Selected Date -> $data");
  }

  _monthNameWidget(monthName) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(monthName,
          style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontStyle: FontStyle.italic)),
    );
  }

  getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: const EdgeInsets.only(left: 1, right: 1),
        width: 7,
        height: 7,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      ),
      Container(
        width: 7,
        height: 7,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      )
    ]);
  }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
    TextStyle normalStyle =
        TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = const TextStyle(
        fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87);
    TextStyle dayNameStyle = TextStyle(fontSize: 14.5, color: fontColor);
    List<Widget> children = [
      Text(dayName, style: dayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    if (isDateMarked == true) {
      children.add(getMarkedIndicatorWidget());
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : Colors.white70,
        borderRadius: const BorderRadius.all(Radius.circular(60)),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  // var currentValue = 20;
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
          height: MediaQuery.of(context).size.height - 172,
          alignment: AlignmentDirectional.center,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CalendarStrip(
                startDate: startDate,
                endDate: endDate,
                onDateSelected: onSelect,
                dateTileBuilder: dateTileBuilder,
                iconColor: Colors.black87,
                monthNameWidget: _monthNameWidget,
                markedDates: markedDates,
                containerDecoration: const BoxDecoration(color: Colors.black12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
