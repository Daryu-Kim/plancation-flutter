import 'package:flutter/material.dart';

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
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 42, vertical: 28),
        ),
      ),
    );
  }
}
