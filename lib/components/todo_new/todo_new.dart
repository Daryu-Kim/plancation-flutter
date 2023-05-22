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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        leading: Row(
          children: const [
            Text(
              '취소',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        title: const Text('새로운 할 일'),
        actions: [
          Row(
            children: const [
              Text(
                '등록',
                style: TextStyle(fontSize: 18),
              ),
            ],
          )
        ],
      ),
      body: Container(),
    );
  }

  // void showBottomSheet() => showModalBottomSheet(
  //     context: context,
  //     builder: (context) => Column(
  //           children: <Widget>[
  //             ListTile(
  //               leading: const Icon(Icons.share),
  //               onTap: () {},
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.link),
  //               onTap: () {},
  //             )
  //           ],
  //         ));
}
