import 'package:flutter/material.dart';

class TodoNew extends StatefulWidget {
  const TodoNew({super.key});

  @override
  _TodoNewState createState() => _TodoNewState();
}

class _TodoNewState extends State<TodoNew> {
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
