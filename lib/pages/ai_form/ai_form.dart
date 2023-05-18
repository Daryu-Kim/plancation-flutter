import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plancation/pages/ai_form/ai_result.dart';

class AIFormPage extends StatefulWidget {
  const AIFormPage({super.key});

  @override
  _AIFormPageState createState() => _AIFormPageState();
}

class _AIFormPageState extends State<AIFormPage> {
  var selectedStartDate;
  var selectedEndDate;
  var selectedStartTime;
  var selectedEndTime;
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    selectedStartDate = DateTime.now();
    selectedEndDate = DateTime.now();
    selectedStartTime = TimeOfDay.now();
    selectedEndTime = TimeOfDay.now();
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 36,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.chevron_left_rounded,
                        color: CupertinoColors.white, size: 28),
                  ),
                ),
                const Text(
                  'AI 입력 폼',
                  style: TextStyle(
                    fontSize: 18,
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 36)
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 84,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '계획 날짜',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 216,
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: DateTime.now(),
                                  minimumDate: DateTime(2020),
                                  maximumDate: DateTime(2025),
                                  onDateTimeChanged: (DateTime pickedDate) {
                                    setState(() {
                                      selectedStartDate = pickedDate;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          '${selectedStartDate.year}-${selectedStartDate.month}-${selectedStartDate.day}',
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 216,
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: DateTime.now(),
                                  minimumDate: DateTime(2020),
                                  maximumDate: DateTime(2025),
                                  onDateTimeChanged: (DateTime pickedDate) {
                                    setState(() {
                                      selectedEndDate = pickedDate;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          '${selectedEndDate.year}-${selectedEndDate.month}-${selectedEndDate.day}',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '계획의 시작과 종료 날짜를 입력해 주세요.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '활동 시간',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 216,
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.time,
                                  initialDateTime: DateTime.now(),
                                  onDateTimeChanged: (DateTime pickedTime) {
                                    setState(() {
                                      selectedStartTime = pickedTime;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          selectedStartTime != null
                              ? '${selectedStartTime!.hour}:${selectedStartTime!.minute}'
                              : '시간 선택',
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 216,
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.time,
                                  initialDateTime: DateTime.now(),
                                  onDateTimeChanged: (DateTime pickedTime) {
                                    setState(() {
                                      selectedEndTime = pickedTime;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          selectedEndTime != null
                              ? '${selectedEndTime!.hour}:${selectedEndTime!.minute}'
                              : '시간 선택',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '활동시간의 시작과 종료 단위를 입력해 주세요.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '계획 주제',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  TextField(
                    onChanged: null,
                    controller: null,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: "Ex) 제주도 여행, 개발일정, 발표준비 등",
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).colorScheme.outlineVariant),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                              width: 2,
                              style: BorderStyle.solid),
                        )),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    '어떤 것을 계획 중이세요?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
              TextField(
                controller: _controller,
              ),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                        onPressed: () {
                          String prompt = _controller.text;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AIResultPage(prompt)),
                          );
                        },
                        child: const Text(
                          '결과 보기',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
