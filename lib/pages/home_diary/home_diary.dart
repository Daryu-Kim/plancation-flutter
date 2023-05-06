import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_diary.style.dart';

class HomeDiaryPage extends StatefulWidget {
  const HomeDiaryPage({super.key});

  @override
  _HomeDiaryPageState createState() => _HomeDiaryPageState();
}

class _HomeDiaryPageState extends State<HomeDiaryPage> {
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
