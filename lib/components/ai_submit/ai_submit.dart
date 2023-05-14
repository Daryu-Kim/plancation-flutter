import 'package:flutter/material.dart';

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
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 42, vertical: 28),
        ),
      ),
    );
  }
}
