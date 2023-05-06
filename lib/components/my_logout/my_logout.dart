import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'my_logout.style.dart';

class MyLogout extends StatefulWidget {
  const MyLogout({super.key});

  @override
  _MyLogoutState createState() => _MyLogoutState();
}

class _MyLogoutState extends State<MyLogout> {
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
