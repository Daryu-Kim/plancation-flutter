import 'package:flutter/material.dart';

class HomeMyComponent extends StatefulWidget {
  const HomeMyComponent({super.key});

  @override
  _HomeMyComponent createState() => _HomeMyComponent();
}

class _HomeMyComponent extends State<HomeMyComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          height: 72,
          child: const Center(
            child: Text(
              '내 계정',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      body: Center(
          child: Flexible(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                children: [Text('data')],
              ),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        '로그아웃',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                        onPressed: null,
                        child: Text(
                          '계정 삭제',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
