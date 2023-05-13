import 'package:flutter/material.dart';

class DiaryListPost extends StatefulWidget {
  const DiaryListPost({super.key});

  @override
  _DiaryListPostState createState() => _DiaryListPostState();
}

class _DiaryListPostState extends State<DiaryListPost> {
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
