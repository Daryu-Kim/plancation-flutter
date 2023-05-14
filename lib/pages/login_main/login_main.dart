import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:plancation/modules/another.dart';
import 'package:plancation/modules/firebase_login.dart';
import 'package:plancation/pages/home.dart';
import 'package:plancation/pages/join/join.dart';
import 'package:plancation/pages/login/login.dart';
import 'package:word_break_text/word_break_text.dart';
import 'login_main.style.dart';

class LoginMainPage extends StatelessWidget {
  const LoginMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? backbuttonpressedTime;

    if (AuthManage().getUser() != null) {
      Future.delayed(Duration.zero, () {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => const HomePage()));
      });
    }

    Future<bool> onWillPop() async {
      DateTime currentTime = DateTime.now();

      //Statement 1 Or statement2
      bool backButton = backbuttonpressedTime == null ||
          currentTime.difference(backbuttonpressedTime!) > Duration(seconds: 3);

      if (backButton) {
        backbuttonpressedTime = currentTime;
        infoSnackBar(context, "한번 더 뒤로가기를 누르면 종료됩니다.");
        return false;
      }
      return true;
      SystemNavigator.pop();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: WillPopScope(
            onWillPop: onWillPop,
            child: Container(
              height: MediaQuery.of(context).size.height - 24,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Column(
                    children: [
                      SizedBox(
                          width: 192,
                          height: 192,
                          child: Theme.of(context).brightness ==
                                  Brightness.light
                              ? SvgPicture.asset('assets/svgs/logo-light.svg')
                              : SvgPicture.asset('assets/svgs/logo-dark.svg')),
                      const SizedBox(height: 72),
                      // 로그인 / 가입 버튼
                      Column(
                        children: [
                          Text('Welcome !', style: welcomeTextStyle(context)),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: OutlinedButton(
                              style: btnOutlineStyle(context),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const JoinPage()));
                              },
                              child: const Text('가입', style: btnTextStyle),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: FilledButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              child: const Text('로그인', style: btnTextStyle),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  WordBreakText(
                      '위의 선택지 중 한개를 누름으로서, '
                      '플랜케이션의 서비스 이용 약관과 개인정보처리방침에 '
                      '동의한 것으로 간주합니다.',
                      wrapAlignment: WrapAlignment.center,
                      spacingByWrap: true,
                      spacing: 2,
                      style: termsTextStyle(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
