import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plancation/pages/diary_new/diary_new.dart';
import 'home_diary.style.dart';

class HomeDiaryPage extends StatefulWidget {
  const HomeDiaryPage({super.key});

  @override
  _HomeDiaryPageState createState() => _HomeDiaryPageState();
}

class _HomeDiaryPageState extends State<HomeDiaryPage> {
  addDiaryPressed() {
    if (mounted) {
      Navigator.push(
          context, CupertinoPageRoute(builder: (context) => const DiaryNew(), fullscreenDialog: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: SafeArea(
          child: Container(
            color: Theme.of(context).colorScheme.secondary,
            height: 60,
            child: const Center(
              child: Text(
                '기록',
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
      body: Container(
        color: Theme.of(context).colorScheme.background,
        alignment: AlignmentDirectional.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 28),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addDiaryPressed,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.surface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
