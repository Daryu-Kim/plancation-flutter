import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:plancation/components/diary_list_post/diary_list_post.dart';
import 'package:plancation/modules/another.dart';
import 'package:plancation/modules/firebase_firestore.dart';
import 'package:plancation/modules/firebase_login.dart';
import 'package:plancation/pages/diary_new/diary_new.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_diary.style.dart';

class HomeDiaryPage extends StatefulWidget {
  const HomeDiaryPage({super.key});

  @override
  _HomeDiaryPageState createState() => _HomeDiaryPageState();
}

class _HomeDiaryPageState extends State<HomeDiaryPage> {
  String calendarID = "";
  dynamic calendarUsers;
  addDiaryPressed() {
    if (mounted) {
      Navigator.push(
          context, CupertinoPageRoute(builder: (context) => const DiaryNew(), fullscreenDialog: true));
    }
  }

  @override
  void initState() {
    super.initState();
    getCalendarID().then((value) {
      setState(() {
        calendarID = value;
      });
    });

    // StoreManage().getCalendarUsers(calendarID).then((value) {
    //   setState(() {
    //     calendarUsers = value;
    //   });
    // });
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: Theme.of(context).colorScheme.background,
        alignment: AlignmentDirectional.topCenter,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Calendars").doc(calendarID).collection("Posts").orderBy('postTime', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(8),
                child: DiaryListPost(diaryData: snapshot.data!.docs[index], calendarUsers: calendarUsers)
              ),
            );
          },
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
