import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'diary_manage.style.dart';

class DiaryManage extends StatefulWidget {
  const DiaryManage({super.key});

  @override
  _DiaryManageState createState() => _DiaryManageState();
}

class _DiaryManageState extends State<DiaryManage> {
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
