import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({super.key});

  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  //제목이 비어있는거 확인용
  bool isTitleEntered = false;
  //하루종일, 구간설정 토글버튼
  var isSelected1 = [false, true];
  var isSelected2 = [false, true];

  //참여자 목록 변수
  String member = '나';
  String member1 = '강해민';
  String member2 = '김원재';
  String member3 = '백승호';
  String member4 = '나';

  //알림 Map
  List<String> alertValue = ["이벤트 당일", "1일 전", "1주 전", "매일", "없음"];
  List<bool> alertBools = List.empty(growable: true);

  //알림 목록 변수

  late String selectedAlert = alertValue[4];

  DateTime? selectedStartDate, selectedEndDate;
  TimeOfDay? selectedStartTime, selectedEndTime;

  //할일 제목 컨트롤
  // TextEditingController titleFieldController = TextEditingController();
  String todoTitle = "";

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
    setState(() {
      todoTitle = text;
      text.isNotEmpty ? isTitleEntered = true : isTitleEntered = false;
    });
  }

  //등록 버튼을 눌렀을 때
  // submitTodo(context) {
  //   StoreManage()
  //       .createTodo(selectedStartDate!, selectedEndDate!, todoTitle, member,
  //           selectedAlert)
  //       .then((value) => Navigator.pop(context));
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 54,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      '취소',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    )),
                const Text(
                  '새로운 할 일',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () => isTitleEntered ? submitTodo(context) : null,
                  child: const Text(
                    '등록',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //👆 여기까지가 Appbar 부분입니다.
        Container(
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
                  constraints: BoxConstraints.expand(
                      width: constraints.maxWidth / 2 - 1.5),
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
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: 1000,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.outlineVariant,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8)),
                      ),
                      child: CupertinoButton(
                        // alignment: Alignment.center,
                        // color: Colors.amber,
                        // padding: EdgeInsets.zero,
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
                              DateFormat('yyyy-MM-dd')
                                  .format(selectedStartDate!),
                            )
                          ],
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
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: 1000,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.outlineVariant,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(8)),
                      ),
                      child: CupertinoButton(
                        // padding: EdgeInsets.zero,
                        // color: Colors.blue,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      width: 1,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: PopupMenuButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  itemBuilder: (BuildContext context) {
                    return [
                      for (final value in alertValue)
                        PopupMenuItem(
                          value: value,
                          child: Text(value),
                        )
                    ];
                  },
                  onSelected: (value) {
                    List<bool> tempList = List.empty(growable: true);
                    for (int i = 0; i < alertValue.length; i++) {
                      tempList.add(alertValue[i] == value);
                    }
                    setState(() {
                      selectedAlert = value.toString();
                      alertBools = tempList;
                    });
                  },
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
                          selectedAlert,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outlineVariant,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ),
              )

              // Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //         color: Theme.of(context).colorScheme.outlineVariant,
              //         width: 1,
              //         style: BorderStyle.solid),
              //     borderRadius: BorderRadius.circular(8.0),
              //   ),
              //   child: PopupMenuButton(
              //     //이게 왜 안먹는지 모르겠어서 패딩으로 묶었습니다;;; 진짜 화나네
              //     // padding: const EdgeInsets.symmetric(
              //     //   vertical: 20,
              //     //   horizontal: 14,
              //     // ),
              //     shape: const RoundedRectangleBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(12))),
              //     child: Padding(
              //       padding: const EdgeInsets.all(14),
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
              //             selectedAlert,
              //             style: TextStyle(
              //               color: Theme.of(context).colorScheme.outlineVariant,
              //               fontSize: 14,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     itemBuilder: (context) {
              //       List<Widget> tempWidgets = List.empty(growable: true);
              //       for (int i = 0; i < alertValue.length; i++) {
              //         tempWidgets.add(PopupMenuItem(
              //           value: alertValue[i],
              //           child: Text(alertValue[i]),
              //         ));
              //       }
              //       return tempWidgets;
              //     },
              //     onSelected: (String selectedValue) {
              //       setState(() {
              //         selectedAlert = selectedValue;
              //         for (int i = 0; i < alertValue.length; i++) {
              //           alertBools[i] = alertValue[i] == selectedValue;
              //         }
              //       });
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
