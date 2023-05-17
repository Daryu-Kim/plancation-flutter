import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plancation/pages/home_todo/home_todo.style.dart';

class HomeTodoPage extends StatefulWidget {
  const HomeTodoPage({super.key});

  @override
  _HomeTodoPageState createState() => _HomeTodoPageState();
}

class _HomeTodoPageState extends State<HomeTodoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SafeArea(
          child: Container(
            color: Theme.of(context).colorScheme.secondary,
            height: 60,
            child: const Center(
              child: Text(
                '할 일 목록',
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 172,
          child: const Text("TODO")
        ),
      ),
    );
  }
}
