import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_todo.style.dart';

class HomeTodoPage extends StatefulWidget {
  const HomeTodoPage({super.key});

  @override
  _HomeTodoPageState createState() => _HomeTodoPageState();
}

class _HomeTodoPageState extends State<HomeTodoPage> {
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
