import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ai_submit.style.dart';

class AISubmit extends StatefulWidget {
  const AISubmit({super.key});

  @override
  _AISubmitState createState() => _AISubmitState();
}

class _AISubmitState extends State<AISubmit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 28),
        ),
      ),
    );
  }
}
