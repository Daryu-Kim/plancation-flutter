import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_ai.style.dart';

class HomeAIPage extends StatefulWidget {
  const HomeAIPage({super.key});

  @override
  _HomeAIPageState createState() => _HomeAIPageState();
}

class _HomeAIPageState extends State<HomeAIPage> {
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
