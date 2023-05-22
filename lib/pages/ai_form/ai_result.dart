import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:plancation/pages/ai_form/ai_loading.dart';
import 'package:plancation/styles/body_style.dart';

class AIResultPage extends StatefulWidget {
  final String prompt;
  const AIResultPage(this.prompt, {super.key});

  @override
  AIResultPageState createState() => AIResultPageState();
}

class AIResultPageState extends State<AIResultPage> {
  String generatedText = '';

  @override
  void initState() {
    super.initState();
    Logger().e(widget.prompt);
    generateText(widget.prompt).then((text) {
      setState(() {
        generatedText = text;
      });
    });
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
        padding: BodyStyle().bodyPadding,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Text(generatedText);
          },
        ),
      ),
    );
  }
}
