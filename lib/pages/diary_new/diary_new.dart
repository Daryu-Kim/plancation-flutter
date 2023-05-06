import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'diary_new.style.dart';

class DiaryNew extends StatefulWidget {
  const DiaryNew({super.key});

  @override
  _DiaryNewState createState() => _DiaryNewState();
}

class _DiaryNewState extends State<DiaryNew> {
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
