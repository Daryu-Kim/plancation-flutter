import 'package:flutter/material.dart';

class JoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Join!"
          ),
        ),
      ),
    );
  }
}