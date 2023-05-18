import 'package:flutter/material.dart';
import 'package:plancation/pages/ai_form/ai_loading.dart';
import 'package:plancation/styles/app_bar_style.dart';
import 'package:plancation/styles/body_style.dart';

class AIResultPage extends StatefulWidget {
  final String prompt;
  const AIResultPage(this.prompt, {super.key});

  @override
  AIResultPageState createState() => AIResultPageState();
}

class AIResultPageState extends State<AIResultPage> {
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
                  '결과창',
                  style: AppBarStyle().appBarTitleStyle,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
            padding: BodyStyle().bodyPadding,
            child: Container(
                alignment: BodyStyle().bodyAlignTopCenter,
                height: MediaQuery.of(context).size.height - 172,
                child: Flexible(
                  fit: FlexFit.tight,
                  child: FutureBuilder<String>(
                    future: generateText(widget.prompt),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text('${snapshot.data}');
                      }
                    },
                  ),
                ))));
  }
}
