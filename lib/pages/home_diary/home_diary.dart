import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
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
  addDiaryPressed() {
    if (mounted) {
      Navigator.push(
          context, CupertinoPageRoute(builder: (context) => const DiaryNew(), fullscreenDialog: true));
    }
  }



  @override
  Widget build(BuildContext context) {
    Logger().e(StoreManage().getDiaryItems());
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
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Calendars").doc(getCalendarID().toString()).collection("Posts").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) => Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text(snapshot.data!.docs[index].toString())
                    ],
                  ),
                ),
              );
            },
          ),
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
