// import 'package:flutter/material.dart';

// class MonthPicker extends StatefulWidget {
//   const MonthPicker(
//       {super.key,
//         required this.initialDate,
//         required this.firstDate,
//         required this.lastDate,
//         required this.onDateSelected});

//   final DateTime initialDate, firstDate, lastDate;
//   final Function(DateTime) onDateSelected;

//   @override
//   MonthPickerState createState() => MonthPickerState();
// }

// class MonthPickerState extends State<MonthPicker> {
//   Column widgetStack = Column();

//   initMonthPicker() {
//     int firstYear = widget.firstDate.year;
//     int lastYear = widget.lastDate.year;
//     for (int currentYear = firstYear; firstYear <= lastYear; firstYear++) {
//       widgetStack.children.add(Text(currentYear.toString()));
//     }
//     return widgetStack;
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.red,
//       child: initMonthPicker()
//     );
//   }
// }