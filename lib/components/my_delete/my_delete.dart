import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'my_delete.style.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 28),
        ),
      ),
    );
  }
}
