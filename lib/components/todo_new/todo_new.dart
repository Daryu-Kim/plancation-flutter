import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:plancation/modules/firebase_storage.dart';
import 'package:plancation/modules/firebase_firestore.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({super.key});

  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  //제목이 비어있는거 확인용
  late bool isTitleEntered;
  //하루종일, 구간설정 토글버튼
  var isSelected1 = [false, true];
  var isSelected2 = [false, true];

  //참여자 목록 변수
  String member = '나';
  String member1 = '강해민';
  String member2 = '김원재';
  String member3 = '백승호';
  String member4 = '나';

  //알림 목록 변수
  String notice = '없음';
  String notice1 = '이벤트당일';
  String notice2 = '1일전';
  String notice3 = '1주전';
  String notice4 = '매일';
  String notice5 = '없음';

  DateTime? selectedStartDate, selectedEndDate;
  TimeOfDay? selectedStartTime, selectedEndTime;

  //할일 제목 컨트롤
  // TextEditingController titleFieldController = TextEditingController();
  String todoTitle = "";

  var fromDate = DateFormat('yyyy-MM-dd\nHH:mm').format(DateTime.now());
  var toDate = DateFormat('yyyy-MM-dd\nHH:mm').format(DateTime.now());

  @override
  void initState() {
    super.initState();

    selectedStartDate = DateTime.now();
    selectedEndDate = DateTime.now().add(const Duration(days: 1));
    // selectedStartTime = TimeOfDay.now();
    // selectedEndTime = TimeOfDay.now();
  }

  //todo제목 바뀔 때
  todoTitleChange(String text) {
    todoTitle = text;
    if (text.isNotEmpty) {
      setState(() {
        isTitleEntered = true;
      });
    } else {
      setState(() {
        isTitleEntered = false;
      });
    }
    setState(() {
      todoTitle = text;
    });
  }

  Future<void> submitTodo(context) async {
    isTitleEntered == true
        ? await StoreManage()
            .createTodo(fromDate, toDate, todoTitle, member, notice)
        : null;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text(
          '새로운 할 일',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: TextButton(
          style: TextButton.styleFrom(padding: const EdgeInsets.only(left: 24)),
          onPressed: () {},
          child: const Text(
            '취소',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),

        // Row(
        //   children: const [
        //     Padding(
        //       padding: EdgeInsets.only(left: 20, right: 0, top: 15, bottom: 15),
        //       child: Text(
        //         '취소',
        //         style: TextStyle(
        //           fontSize: 18,
        //           color: Colors.white,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),

        actions: [
          TextButton(
              onPressed: () => submitTodo(context),
              child: const Text(
                '등록',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ))
          // Row(
          //   children: const [
          //     Text(
          //       '등록',
          //       style: TextStyle(
          //         fontSize: 18,
          //         color: Colors.white,
          //       ),
          //     ),
          //     Padding(padding: EdgeInsets.all(10)),
          //   ],
          // )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            TextField(
              onChanged: todoTitleChange,
              controller: null,
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: "할 일 제목",
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  fontSize: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      width: 1,
                      style: BorderStyle.solid),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary,
                    width: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            //토글버튼 하루종일 or 구간설정
            LayoutBuilder(
              builder: (context, constraints) => ToggleButtons(
                constraints:
                    BoxConstraints.expand(width: constraints.maxWidth / 2.016),
                borderColor: Theme.of(context).colorScheme.outlineVariant,
                fillColor: Theme.of(context).colorScheme.tertiary,
                borderWidth: 1,
                selectedBorderColor:
                    Theme.of(context).colorScheme.outlineVariant,
                selectedColor: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < isSelected2.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected2[buttonIndex] = true;
                      } else {
                        isSelected2[buttonIndex] = false;
                      }
                    }
                  });
                },
                isSelected: isSelected2,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '하루종일',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '구간설정',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            // 구간설정의 단위기간 타임피커 설정 ----- 이부분에 붙여넣기?

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) => CupertinoButton(
                    // alignment: Alignment.center,
                    // color: Colors.amber,
                    padding: EdgeInsets.zero,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 46),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.outlineVariant,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8)),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            '시작',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd').format(selectedStartDate!),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) => SizedBox(
                                height: 250,
                                child: CupertinoDatePicker(
                                  backgroundColor: Colors.white,
                                  initialDateTime: selectedStartDate,
                                  minimumDate: DateTime.now()
                                      .add(const Duration(minutes: -5)),
                                  // maximumDate: selectedEndDate,
                                  onDateTimeChanged: (DateTime newTime) {
                                    setState(() {
                                      selectedStartDate = newTime;
                                      print(selectedStartDate);
                                    });
                                  },
                                  use24hFormat: true,
                                  mode: CupertinoDatePickerMode.date,
                                ),
                              ));
                    },
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) => CupertinoButton(
                    padding: EdgeInsets.zero,
                    // color: Colors.blue,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 46),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.outlineVariant,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(8)),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            '종료',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd').format(selectedEndDate!),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) => SizedBox(
                                height: 250,
                                child: CupertinoDatePicker(
                                  backgroundColor: Colors.white,
                                  initialDateTime: selectedEndDate,
                                  minimumDate: DateTime.now()
                                      .add(const Duration(minutes: -5)),
                                  // maximumDate: selectedEndDate,
                                  onDateTimeChanged: (DateTime pickedDate) {
                                    setState(() {
                                      selectedEndDate = pickedDate;
                                      print(selectedEndDate);
                                    });
                                  },
                                  use24hFormat: true,
                                  mode: CupertinoDatePickerMode.date,
                                ),
                              ));
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 16,
            ),

            //참여자 목록
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    width: 1,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: PopupMenuButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '참여자',
                        style: TextStyle(
                          color: Color.fromARGB(255, 86, 86, 86),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        member,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outlineVariant,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: member1,
                    child: Text(member1),
                  ),
                  PopupMenuItem(
                    value: member2,
                    child: Text(member2),
                  ),
                  PopupMenuItem(
                    value: member3,
                    child: Text(member3),
                  ),
                  PopupMenuItem(
                    value: member4,
                    child: Text(member4),
                  ),
                ],
                onSelected: (String newvalue) {
                  setState(() {
                    member = newvalue;
                    print(member);
                  });
                },
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            //알림 버튼목록

            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    width: 1,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: PopupMenuButton(
                //이게 왜 안먹는지 모르겠어서 패딩으로 묶었습니다;;; 진짜 화나네
                // padding: const EdgeInsets.symmetric(
                //   vertical: 20,
                //   horizontal: 14,
                // ),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '알림',
                        style: TextStyle(
                          color: Color.fromARGB(255, 86, 86, 86),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        notice,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outlineVariant,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: notice1,
                    child: Text(notice1),
                  ),
                  PopupMenuItem(
                    value: notice2,
                    child: Text(notice2),
                  ),
                  PopupMenuItem(
                    value: notice3,
                    child: Text(notice3),
                  ),
                  PopupMenuItem(
                    value: notice4,
                    child: Text(notice4),
                  ),
                  PopupMenuItem(
                    value: notice5,
                    child: Text(notice5),
                  ),
                ],
                onSelected: (String newvalue) {
                  setState(() {
                    notice = newvalue;
                    print(notice);
                  });
                },
              ),
            ),

            //예비용
            // Container(
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //         color: Theme.of(context).colorScheme.outlineVariant,
            //         width: 1,
            //         style: BorderStyle.solid),
            //     borderRadius: BorderRadius.circular(8.0),
            //   ),
            //   child: TextButton(
            //       style: const ButtonStyle(
            //         padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
            //           vertical: 0,
            //           horizontal: 14,
            //         )),
            //       ),
            //       onPressed: () {},
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           const Text(
            //             '알림',
            //             style: TextStyle(
            //               color: Color.fromARGB(255, 86, 86, 86),
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           Text(
            //             '없음',
            //             style: TextStyle(
            //               color: Theme.of(context).colorScheme.outlineVariant,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ],
            //       )),
            // ),
          ],
        ),
      ),
    );
  }
}
