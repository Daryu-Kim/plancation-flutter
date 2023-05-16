import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plancation/components/diary_list_post/diary_list_post.dart';
import 'package:plancation/modules/another.dart';
import 'package:plancation/pages/diary_form/diary_form.dart';
import 'package:plancation/styles/app_bar_style.dart';
import 'package:plancation/styles/body_style.dart';

class HomeDiaryPage extends StatefulWidget {
  const HomeDiaryPage({super.key});

  @override
  HomeDiaryPageState createState() => HomeDiaryPageState();
}

class HomeDiaryPageState extends State<HomeDiaryPage> {
  String calendarID = "";
  List postSnapshot = List.empty(growable: true);

  addDiaryBtnTap() {
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
  
  Future<void> onRefresh() async{
    List tempList = List.empty(growable: true);
    String tempCalendarID = await getCalendarID();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Calendars")
        .doc(tempCalendarID)
        .collection("Posts")
        .orderBy('postTime', descending: true)
        .get();

    for (var docSnapshot in querySnapshot.docs) {
      tempList.add(docSnapshot.data());
    }

    setState(() {
      calendarID = tempCalendarID;
      postSnapshot = tempList;
    });
  }

  @override
  void initState() {
    super.initState();
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBarStyle().appBarSize),
        child: SafeArea(
          child: Container(
            color: AppBarStyle().appBarBackgroundColor(context),
            height: AppBarStyle().appBarSize,
            child: Center(
              child: Text(
                '기록',
                style: AppBarStyle().appBarTitleStyle,
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Container(
          padding: BodyStyle().bodyPadding,
          alignment: BodyStyle().bodyAlignTopCenter,
          child: calendarID.isNotEmpty ?
              postSnapshot.isNotEmpty ?
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: postSnapshot.length,
                itemBuilder: (ctx, index) => Container(
                    padding: const EdgeInsets.all(8),
                    child: DiaryListPost(diaryData: postSnapshot[index], calendarID: calendarID,)
                ),
              )
                  : const CircularProgressIndicator()
              : const CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addDiaryBtnTap,
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
