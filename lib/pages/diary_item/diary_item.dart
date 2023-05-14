import 'package:flutter/material.dart';

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
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 42, vertical: 28),
        ),
      ),
    );
  }
}
