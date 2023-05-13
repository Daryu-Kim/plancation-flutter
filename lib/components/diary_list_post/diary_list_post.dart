import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plancation/modules/firebase_firestore.dart';
import 'diary_list_post.style.dart';

class DiaryListPost extends StatefulWidget {
  const DiaryListPost({super.key, required this.diaryData, required this.calendarUsers});

  final dynamic diaryData, calendarUsers;

  @override
  _DiaryListPostState createState() => _DiaryListPostState();
}

class _DiaryListPostState extends State<DiaryListPost> {
  String userName = "";
  @override
  void initState(){
    super.initState();
    FirebaseFirestore.instance.collection('Users').doc(widget.diaryData['postAuthorID']).get().then((value) {
      setState(() {
        userName = value.toString();
      });
    });
    // StoreManage().getDiaryAuthorName(widget.diaryData['postAuthorID']).then((value) {
    //   setState(() {
    //     userName = value;
    //   });
    // });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
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
            Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // widget.calendarUsers.length != 1 ?
                        //     Container(
                        //       child: Text(
                        //         userName,
                        //         style: const TextStyle(
                        //           fontWeight: FontWeight.w500,
                        //           fontSize: 14,
                        //           color: CupertinoColors.white
                        //         ),
                        //       ),
                        //       padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        //       color: Theme.of(context).colorScheme.secondaryContainer,
                        //     ) : const SizedBox(),
                        // widget.calendarUsers.length == 1 ?
                        //     const SizedBox(width: 8) : const SizedBox(),
                        Text(widget.diaryData['postTitle'],
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.start,
                            style: TextStyle(
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
                )),
            widget.diaryData['postImagePath'].isNotEmpty
                ? SizedBox(width: 12)
                : SizedBox(),
            widget.diaryData['postImagePath'].isNotEmpty
                ? Container(
                    height: 64,
                    width: 64,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Image.network(widget.diaryData['postImagePath']))
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
