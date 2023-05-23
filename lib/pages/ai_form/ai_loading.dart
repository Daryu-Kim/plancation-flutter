import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:plancation/styles/app_bar_style.dart';
import 'package:plancation/styles/body_style.dart';
import 'package:http/http.dart' as http;

const apiKey = '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';
const apiUrl = 'https://api.openai.com/v1/completions';

Future<String> generateText(String prompt) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    },
    body: jsonEncode({
      "model": "text-davinci-003",
      'prompt': prompt,
      'max_tokens': 10000,
      'temperature': 0,
      'top_p': 1,
      'frequency_penalty': 0,
      'presence_penalty': 0
    }),
  );

  Map<String, dynamic> newresponse =
      jsonDecode(utf8.decode(response.bodyBytes));
  Logger().e(newresponse);

  return newresponse['choices'][0]['text'];
}

class AILoadingPage extends StatefulWidget {
  const AILoadingPage({super.key});

  @override
  AILoadingPageState createState() => AILoadingPageState();
}

class AILoadingPageState extends State<AILoadingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBarStyle().appBarSize),
        child: SafeArea(
          child: Container(
            color: AppBarStyle().appBarBackgroundColor(context),
            height: AppBarStyle().appBarSize,
            child: Center(
              child: Text(
                '형식상 로딩중',
                style: AppBarStyle().appBarTitleStyle,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: BodyStyle().bodyPadding,
        alignment: BodyStyle().bodyAlignTopCenter,
        child: Column(children: const []),
      ),
    );
  }
}
