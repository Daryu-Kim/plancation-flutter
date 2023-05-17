import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAIPage extends StatefulWidget {
  const HomeAIPage({Key? key}) : super(key: key);

  @override
  _HomeAIPageState createState() => _HomeAIPageState();
}

class _HomeAIPageState extends State<HomeAIPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
          height: MediaQuery.of(context).size.height - 172,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '계획짜기 어려우시죠?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Plancation ',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const TextSpan(
                          text: ' 은 사용자에게 맞춘\n맞춤 스케줄링 서비스를 제공합니다.',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Flexible(
                fit: FlexFit.tight,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.scale(
                      scale: 1.0 + (_animation.value * 0.12),
                      child: Image.asset(
                        'assets/images/auto_schedule.png',
                        width: double.infinity,
                      ),
                    );
                  },
                ),
              ),
              Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      '날짜 또는 기간, 활동 가능 시간, 주제에 대해 작성만 해주세요!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                        onPressed: null,
                        child: Text(
                          '이용하러 가기',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
