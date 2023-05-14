import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAIPage extends StatefulWidget {
  const HomeAIPage({super.key});

  @override
  _HomeAIPageState createState() => _HomeAIPageState();
}

class _HomeAIPageState extends State<HomeAIPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: SafeArea(
          child: Container(
            color: Theme.of(context).colorScheme.secondary,
            height: 60,
            child: const Center(
              child: Text(
                'Auto Schedule',
                style: TextStyle(
                  fontSize: 18,
                  color: CupertinoColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height - 172,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: const Text("AI"),
        ),
      ),
    );
  }
}
