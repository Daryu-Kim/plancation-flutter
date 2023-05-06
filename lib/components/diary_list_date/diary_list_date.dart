import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'diary_list_date.style.dart';

class DiaryListDate extends StatefulWidget {
  const DiaryListDate({super.key});

  @override
  _DiaryListDateState createState() => _DiaryListDateState();
}

class _DiaryListDateState extends State<DiaryListDate> {
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
