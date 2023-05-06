import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'diary_item.style.dart';

class DiaryItemPage extends StatefulWidget {
  const DiaryItemPage({super.key});

  @override
  _DiaryItemPageState createState() => _DiaryItemPageState();
}

class _DiaryItemPageState extends State<DiaryItemPage> {
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
