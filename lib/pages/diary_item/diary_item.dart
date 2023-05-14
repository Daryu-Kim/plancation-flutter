import 'package:flutter/cupertino.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SafeArea(
          child: Container(
            color: Theme.of(context).colorScheme.secondary,
            height: 60,
            child: const Center(
              child: Text(
                'Diary Item',
                style: TextStyle(
                  fontSize: 18,
                  color: CupertinoColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height - 84,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16))),
    );
  }
}
