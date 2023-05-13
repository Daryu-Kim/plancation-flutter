import 'package:flutter/material.dart';

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
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 42, vertical: 28),
        ),
      ),
    );
  }
}
