import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:plancation/pages/ai_form/ai_loading.dart';
import 'package:plancation/styles/body_style.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../modules/another.dart';

class AIResultPage extends StatefulWidget {
  final String prompt;
  const AIResultPage(this.prompt, {super.key});

  @override
  AIResultPageState createState() => AIResultPageState();
}

class AIResultPageState extends State<AIResultPage> {
  List<Map<String, dynamic>> events = [];
  dynamic token;

  @override
  void initState() {
    super.initState();
    Logger().e(widget.prompt);
    generateText(widget.prompt).then(
      (text) {
        setState(() {
          token = jsonDecode(text.substring(3));
        });
      },
    );
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
                  '결과창',
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
      body: Container(
        height: setBodyHeightNotIncludeBNB(context),
        padding: BodyStyle().bodyPadding,
        child: ListView.builder(
          itemCount: token == null ? 0 : token.length,
          itemBuilder: (BuildContext context, int index) {
            String date = token[index]['date'];
            String startTime = token[index]['startTime'];
            String endTime = token[index]['endTime'];
            String content = token[index]['content'];

            return Slidable(
              endActionPane: ActionPane(
                extentRatio: 0.4,
                motion: const ScrollMotion(),
                children: [
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 68,
                    height: 68,
                    child: SlidableAction(
                      onPressed: null,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(6),
                        topLeft: Radius.circular(6),
                      ),
                      icon: Icons.abc,
                      label: "수정",
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                  SizedBox(
                    width: 68,
                    height: 68,
                    child: SlidableAction(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                      onPressed: null,
                      icon: Icons.delete,
                      label: "삭제",
                      backgroundColor:
                          Theme.of(context).colorScheme.errorContainer,
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index > 0 && token[index - 1]['date'] != date ||
                        index == 0) ...[
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ] else ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: 8),
                            right: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: 1),
                            top: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: 1),
                            bottom: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: 1),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              '${double.parse(startTime.substring(0, 2)) > 12 ? "오후 ${(double.parse(startTime.substring(0, 2))-12).floor().toString().padLeft(2, '0')}${startTime.substring(2)}" : "오전 $startTime"} - \n ${endTime.startsWith('12') ? "오후 $endTime" : "오전 $endTime"}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              content,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    ]
                    ,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
