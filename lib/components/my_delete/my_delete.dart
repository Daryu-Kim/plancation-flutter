import 'package:flutter/material.dart';

class MyDelete extends StatefulWidget {
  const MyDelete({super.key});

  @override
  _MyDeleteState createState() => _MyDeleteState();
}

class _MyDeleteState extends State<MyDelete> {
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
