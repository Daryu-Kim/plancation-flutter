import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:plancation/components/diary_list_post/diary_list_post.dart';
import 'package:plancation/modules/another.dart';
import 'package:plancation/pages/diary_form/diary_form.dart';

class HomeDiaryPage extends StatefulWidget {
  const HomeDiaryPage({super.key});

  @override
  _HomeDiaryPageState createState() => _HomeDiaryPageState();
}

class _HomeDiaryPageState extends State<HomeDiaryPage> {
  String calendarID = "";
  addDiaryPressed() {
    if (mounted) {
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => const DiaryForm(
                appBarTitle: '글쓰기',
                appBarBtn: '등록',
                postTitle: "",
                postContent: "",
                postImagePath: "",
                postID: "",
              ), fullscreenDialog: true));
    }
  }
  
  Future<void> onRefresh() async {
    Logger().e("message");
  }

  @override
  void initState() {
    super.initState();
    getCalendarID().then((value) {
      setState(() {
        calendarID = value;
      });
    });
  }

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
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          alignment: AlignmentDirectional.topCenter,
          child: calendarID.isNotEmpty ? StreamBuilder(
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
                  padding: const EdgeInsets.all(8),
                  child: DiaryListPost(diaryData: snapshot.data!.docs[index], calendarID: calendarID,)
                ),
              );
            },
          ) : const CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addDiaryPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
