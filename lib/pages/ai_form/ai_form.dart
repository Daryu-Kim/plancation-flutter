import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ai_form.style.dart';

class AIFormPage extends StatefulWidget {
  const AIFormPage({super.key});

  @override
  _AIFormPageState createState() => _AIFormPageState();
}

class _AIFormPageState extends State<AIFormPage> {
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
