import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/todo_new/todo_new.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  // const TodoList(
  //     {super.key, required this.diaryData, required this.calendarID});

  // final Map diaryData;
  // final String calendarID;

  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  int calendarUsersCount = 1;
  String authorName = "";
  String? authorImagePath;

  void showBottomSheet() => showModalBottomSheet(
        context: context,
        builder: (context) => const TodoForm(),
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(
        //   top: Radius.circular(25.0),
        // )),
        // <Widget>[
        //   ListTile(
        //     leading: const Icon(Icons.share),
        //     onTap: () {},
        //   ),
        //   ListTile(
        //     leading: const Icon(Icons.link),
        //     onTap: () {},
        //   )
        // ],
      );

  // Future<Map?> getAuthorData() async {
  //   try {
  //     final tempData = await FirebaseFirestore.instance
  //         .collection('Users')
  //         .doc(widget.diaryData['postAuthorID'])
  //         .get();
  //     final result = tempData.data();
  //     return result;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  Future<Map?> getCalendarData(String calendarID) async {
    try {
      final tempData = await FirebaseFirestore.instance
          .collection('Calendars')
          .doc(calendarID)
          .get();
      final result = tempData.data();
      return result;
    } catch (e) {
      return null;
    }
  }

  // Future<void> modifyBtnTap(BuildContext context) async {
  //   if (widget.diaryData['postAuthorID'] == AuthManage().getUser()!.uid) {
  //     showBottomSheet();
  //   } else {
  //     errorSnackBar(context, "본인의 기록만 수정할 수 있습니다!");
  //   }
  // }

  // Future<void> deleteBtnTap(context) async {
  //   if (widget.diaryData['postAuthorID'] == AuthManage().getUser()!.uid) {
  //     await StoreManage().deleteDiary(
  //         widget.diaryData['postID'], widget.diaryData['postImagePath']);
  //     submitSnackBar(context, "기록이 삭제되었습니다!");
  //   } else {
  //     errorSnackBar(context, "본인의 기록만 삭제할 수 있습니다!");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          const SizedBox(width: 8),
          SlidableAction(
            onPressed: print,
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
            onPressed: print,
            icon: Icons.delete,
            label: "삭제",
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            foregroundColor: Theme.of(context).colorScheme.error,
          )
        ],
      ),
      //todo리스트 컨테이너 스타일링
      child: Container(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        height: 80,
        child: Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black, width: 0.5),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  color: Colors.deepPurple,
                ),
                width: 6,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    '할일 제목',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 58, 58, 58),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '시간설정했으면 들어가게',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 58, 58, 58),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Container(
                height: 45,
                width: 45,
                decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text('참여자'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // child: Container(
      //   width: double.infinity,
      //   height: 80,
      //   alignment: Alignment.center,
      //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      //   child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       //박스안의 컨텐츠들
      //       children: [
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: const [
      //             Text(
      //               '할일 제목',
      //               style: TextStyle(
      //                 fontSize: 18,
      //                 color: Color.fromARGB(255, 58, 58, 58),
      //               ),
      //               textAlign: TextAlign.center,
      //             ),
      //             Text(
      //               '시간설정했으면 들어가게',
      //               style: TextStyle(
      //                 fontSize: 16,
      //                 color: Color.fromARGB(255, 58, 58, 58),
      //               ),
      //               textAlign: TextAlign.center,
      //             ),
      //           ],
      //         ),
      //         const SizedBox(width: 12),
      //         Container(
      //           height: 45,
      //           width: 45,
      //           decoration: const BoxDecoration(
      //               color: Colors.amber,
      //               borderRadius: BorderRadius.all(Radius.circular(30))),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: const [
      //               Text('참여자'),
      //             ],
      //           ),
      //         ),
      //       ]),
      // ),
    );
  }
}
