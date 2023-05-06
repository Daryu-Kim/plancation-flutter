import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'diary_list_post.style.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 28),
        ),
      ),
    );
  }
}
