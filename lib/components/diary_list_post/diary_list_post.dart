import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:plancation/modules/another.dart';
import 'package:plancation/modules/firebase_firestore.dart';
import 'package:plancation/modules/firebase_login.dart';
import 'package:plancation/pages/diary_item/diary_item.dart';

import '../../pages/diary_form/diary_form.dart';

class DiaryListPost extends StatefulWidget {
  const DiaryListPost(
      {super.key, required this.diaryData, required this.calendarID});

  final dynamic diaryData, calendarID;

  @override
  DiaryListPostState createState() => DiaryListPostState();
}

class DiaryListPostState extends State<DiaryListPost> {
  Future<dynamic> getAuthorName() async {
    try {
      final result = await FirebaseFirestore.instance.collection('Users').doc(widget.diaryData['postAuthorID']).get();
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getCalendarUsers(calendarID) async {
    try {
      final tempData = await FirebaseFirestore.instance.collection('Calendars').doc(calendarID).get();
      final result = tempData;
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<void> onModifyClicked(BuildContext context) async {
    if (widget.diaryData['postAuthorID'] == AuthManage().getUser()!.uid) {
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => DiaryForm(
                    appBarTitle: '글 수정',
                    appBarBtn: '수정',
                    postID: widget.diaryData['postID'],
                    postTitle: widget.diaryData['postTitle'],
                    postContent: widget.diaryData['postContent'],
                    postImagePath: widget.diaryData['postImagePath'],
                  ),
              fullscreenDialog: true));
    } else {
      errorSnackBar(context, "본인의 기록만 수정할 수 있습니다!");
    }
  }

  Future<void> onDeleteClicked(context) async {
    if (widget.diaryData['postAuthorID'] == AuthManage().getUser()!.uid) {
      await StoreManage().deleteDiary(widget.diaryData['postID']);
      submitSnackBar(context, "기록이 삭제되었습니다!");
    } else {
      errorSnackBar(context, "본인의 기록만 삭제할 수 있습니다!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          const SizedBox(width: 8),
          SlidableAction(
            onPressed: onModifyClicked,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(6), topLeft: Radius.circular(6)),
            icon: Icons.abc,
            label: "수정",
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          SlidableAction(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(6), topRight: Radius.circular(6)),
            onPressed: onDeleteClicked,
            icon: Icons.delete,
            label: "삭제",
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            foregroundColor: Theme.of(context).colorScheme.error,
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => DiaryItemPage(
                    diaryData: widget.diaryData
                  )));
        },
        child: Container(
          width: double.infinity,
          height: 80,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6)),
              color: Theme.of(context).colorScheme.tertiaryContainer,
              shape: BoxShape.rectangle),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('EEE')
                      .format(widget.diaryData['postTime'].toDate())
                      .toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  DateFormat('d')
                      .format(widget.diaryData['postTime'].toDate())
                      .toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      FutureBuilder(
                        future: getCalendarUsers(widget.calendarID),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData == false) {
                            return const CircularProgressIndicator(); // CircularProgressIndicator : 로딩 에니메이션
                          }

                          // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 부분
                          else {
                            // Logger().e("calendarUsers is " + snapshot.data['calendarUsers'].length);
                            if (snapshot.data['calendarUsers'].length != 1) {
                              return Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 8),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(100),
                                        color:
                                        Theme.of(context).colorScheme.inversePrimary),
                                    child: FutureBuilder(
                                      future: getAuthorName(),
                                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                                        if (snapshot.hasData == false) {
                                          return const CircularProgressIndicator(); // CircularProgressIndicator : 로딩 에니메이션
                                        } else {
                                          return Text(snapshot.data['userName'],
                                              style: const TextStyle(
                                                  fontSize: 12, fontWeight: FontWeight.w700));
                                        }
                                      },
                                    )
                                    ,
                                  ),
                                  const SizedBox(width: 4)
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          }
                        },
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(widget.diaryData['postTitle'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.diaryData['postContent'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.outline),
                  ),
                ],
              ),
            ),
            widget.diaryData['postImagePath'].isNotEmpty
                ? const SizedBox(width: 12)
                : const SizedBox(),
            widget.diaryData['postImagePath'].isNotEmpty
                ? Container(
                    height: 64,
                    width: 64,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        widget.diaryData['postImagePath'],
                      ),
                    ))
                : const SizedBox(),
          ]),
        ),
      ),
    );
  }
}
