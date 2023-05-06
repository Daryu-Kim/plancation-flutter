import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'find_pw.style.dart';

class FindPwPage extends StatefulWidget {
  const FindPwPage({super.key});

  @override
  _FindPwPageState createState() => _FindPwPageState();
}

class _FindPwPageState extends State<FindPwPage> {
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
