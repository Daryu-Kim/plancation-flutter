import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plancation/pages/ai_form/ai_result.dart';

class AIFormPage extends StatefulWidget {
  const AIFormPage({Key? key}) : super(key: key);

  @override
  _AIFormPageState createState() => _AIFormPageState();
}

class _AIFormPageState extends State<AIFormPage> {
  DateTime? selectedStartDate, selectedEndDate;
  TimeOfDay? selectedStartTime, selectedEndTime;

  String? enteredSubject;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedStartDate = DateTime.now();
    selectedEndDate = DateTime.now().add(const Duration(days: 1));
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
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CupertinoButton(
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 300,
                                  child: CupertinoDatePicker(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    mode: CupertinoDatePickerMode.date,
                                    initialDateTime: selectedStartDate,
                                    minimumDate: DateTime.now()
                                        .add(const Duration(minutes: -5)),
                                    maximumDate: selectedEndDate,
                                    onDateTimeChanged: (DateTime pickedDate) {
                                      setState(
                                        () {
                                          selectedStartDate = pickedDate;
                                        },
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            DateFormat('yyyy-MM-dd').format(selectedStartDate!),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary),
                          ),
                        ),
                        const Text('-'),
                        CupertinoButton(
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 300,
                                  child: CupertinoDatePicker(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    mode: CupertinoDatePickerMode.date,
                                    initialDateTime: selectedEndDate,
                                    minimumDate: selectedStartDate,
                                    maximumDate: DateTime.now()
                                        .add(const Duration(days: 730)),
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
                          child: Text(DateFormat('yyyy-MM-dd')
                              .format(selectedEndDate!)),
                        ),
                      ],
                    ),
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
                  const SizedBox(height: 32),
                  Text(
                    '활동 시간',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CupertinoButton(
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 300,
                                  child: CupertinoDatePicker(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    mode: CupertinoDatePickerMode.time,
                                    initialDateTime: DateTime(
                                      selectedStartDate!.year,
                                      selectedStartDate!.month,
                                      selectedStartDate!.day,
                                      selectedStartTime!.hour,
                                      selectedStartTime!.minute,
                                    ),
                                    onDateTimeChanged: (pickedTime) {
                                      setState(() {
                                        selectedStartTime =
                                            TimeOfDay.fromDateTime(pickedTime);
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            selectedStartTime != null
                                ? DateFormat('HH:mm').format(DateTime(
                                    selectedStartDate!.year,
                                    selectedStartDate!.month,
                                    selectedStartDate!.day,
                                    selectedStartTime!.hour,
                                    selectedStartTime!.minute,
                                  ))
                                : '시간 선택',
                          ),
                        ),
                        const Text('-'),
                        CupertinoButton(
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 300,
                                  child: CupertinoDatePicker(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    mode: CupertinoDatePickerMode.time,
                                    initialDateTime: DateTime(
                                      selectedEndDate!.year,
                                      selectedEndDate!.month,
                                      selectedEndDate!.day,
                                      selectedEndTime!.hour,
                                      selectedEndTime!.minute,
                                    ),
                                    onDateTimeChanged: (DateTime pickedTime) {
                                      setState(() {
                                        selectedEndTime =
                                            TimeOfDay.fromDateTime(pickedTime);
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            selectedEndTime != null
                                ? DateFormat('HH:mm').format(DateTime(
                                    selectedEndDate!.year,
                                    selectedEndDate!.month,
                                    selectedEndDate!.day,
                                    selectedEndTime!.hour,
                                    selectedEndTime!.minute,
                                  ))
                                : '시간 선택',
                          ),
                        ),
                      ],
                    ),
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
                  const SizedBox(height: 32),
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
                    onChanged: (value) {
                      enteredSubject = value;
                    },
                    controller: _controller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      hintText: "Ex) 제주도 여행, 개발일정, 발표준비 등",
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
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
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                        onPressed: () {
                          String prompt =
                              '${DateFormat('yyyy-MM-dd').format(selectedStartDate!)}부터 ${DateFormat('yyyy-MM-dd').format(selectedEndDate!)}까지 $enteredSubject을 할거야 활동시간은 ${DateFormat('HH:mm').format(DateTime(selectedStartDate!.year, selectedStartDate!.month, selectedStartDate!.day, selectedStartTime!.hour, selectedStartTime!.minute))}부터 ${DateFormat('HH:mm').format(DateTime(selectedEndDate!.year, selectedEndDate!.month, selectedEndDate!.day, selectedEndTime!.hour, selectedEndTime!.minute))}까지고 일정은 여유있게 계획 세워줘';
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
