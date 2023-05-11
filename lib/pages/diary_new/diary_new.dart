import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'diary_new.style.dart';

class DiaryNew extends StatefulWidget {
  const DiaryNew({super.key});

  @override
  _DiaryNewState createState() => _DiaryNewState();
}

class _DiaryNewState extends State<DiaryNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: SafeArea(
          child: Container(
            color: Theme.of(context).colorScheme.secondary,
            height: 72,
            child: Row(
              children: [
                TextButton(onPressed: (){}, child: Text("취소")),
                Text(
                  '글쓰기',
                  style: TextStyle(
                    fontSize: 18,
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        TextButton(onPressed: (){}, child: Text("등록"))
              ],
            ),
          ),
        ),
      ),
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 28),
        ),
      ),
    );
  }
}
