import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
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

class HomeDiaryPageState extends State<HomeDiaryPage> with WidgetsBindingObserver {
  String calendarID = "";
  List postSnapshot = List.empty(growable: true);
  Timestamp currentTimestamp = Timestamp.now();

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
                    postImagePath: null,
                    postID: "",
                  ),
              fullscreenDialog: true));
    }
  }

  Future<void> getPostData(Timestamp timestamp) async {
    List tempList = List.empty(growable: true);
    String tempCalendarID = await getCalendarID();
    Timestamp endRange = Timestamp.fromDate(timestamp.toDate().add(const Duration(days: 1)));
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Calendars")
        .doc(tempCalendarID)
        .collection("Posts")
        .where("postTime", isGreaterThanOrEqualTo: timestamp)
        .where("postTime", isLessThan: endRange)
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
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getPostData(Timestamp.fromDate(DateTime.now()));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getPostData(currentTimestamp);
    }
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
      body: Container(
        padding: BodyStyle().bodyPadding,
        alignment: BodyStyle().bodyAlignTopCenter,
        child: Column(
          children: [
            CalendarTimeline(
              initialDate: currentTimestamp.toDate(),
              firstDate: DateTime.utc(DateTime.now().year - 1),
              lastDate: DateTime.now(),
              onDateSelected: (selectedDate) {
                setState(() {
                  currentTimestamp = Timestamp.fromDate(selectedDate);
                });
                getPostData(currentTimestamp);
                Logger().e(selectedDate);
              },

              activeBackgroundDayColor: Theme.of(context).colorScheme.tertiary,
              dayColor: Theme.of(context).colorScheme.primary,
              showYears: true,
            ),
            const SizedBox(height: 24),
            postSnapshot.isNotEmpty
                    ? Flexible(
              fit: FlexFit.tight,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: postSnapshot.length,
                          itemBuilder: (ctx, index) => DiaryListPost(
                            diaryData: postSnapshot[index],
                            calendarID: calendarID,
                          ),
                        ),
                    )
                    : Flexible(
              fit: FlexFit.tight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/notification_important.svg',
                            width: 96,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "기록이 없습니다!",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          )
                        ],
                      ),
                    ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addDiaryBtnTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
