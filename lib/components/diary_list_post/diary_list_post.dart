import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:plancation/modules/another.dart';
import 'package:plancation/modules/firebase_firestore.dart';
import 'package:plancation/modules/firebase_login.dart';
import 'diary_list_post.style.dart';

class DiaryListPost extends StatefulWidget {
  const DiaryListPost({super.key, required this.diaryData, required this.calendarUsers});

  final dynamic diaryData, calendarUsers;

  @override
  _DiaryListPostState createState() => _DiaryListPostState();
}

class _DiaryListPostState extends State<DiaryListPost> {
  Future<void> onModifyClicked(BuildContext context) async {
    if (widget.diaryData['postAuthorID'] == AuthManage().getUser()!.uid) {
      // await StoreManage().deleteDiary(widget.diaryData['postID']);
      submitSnackBar(context, "기록이 수정되었습니다!");
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
          SlidableAction(
            onPressed: onModifyClicked,
            icon: Icons.abc, label: "수정",
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          SlidableAction(
              onPressed: onDeleteClicked,
            icon: Icons.delete, label: "삭제",
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            foregroundColor: Theme.of(context).colorScheme.error,
          )
        ],
      ),
      child: InkWell(
        onTap: null,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.rectangle),
          child: Row(
            children: [
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
                      color: Theme.of(context).colorScheme.primary,
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
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(width: 12),
            Expanded(
              child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(widget.diaryData['postTitle'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700)),
                          ],
                        ),
                        Text(
                          widget.diaryData['postContent'],
                          maxLines: 3,
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
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Image.network(widget.diaryData['postImagePath']))
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
