import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plancation/modules/firebase_login.dart';
import 'package:plancation/pages/find_pw/find_pw.dart';
import 'package:plancation/pages/join/join.dart';
import 'login.style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _inputID = "";
  String _inputPW = "";

  handleBtnClick() {
    AuthManage().signIn(_inputID, _inputPW, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 28),
          child: Column(
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 128,
                        height: 128,
                        child: Theme.of(context).brightness == Brightness.light
                            ? SvgPicture.asset('assets/svgs/logo-light.svg')
                            : SvgPicture.asset('assets/svgs/logo-dark.svg')),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 52,
                      child: TextField(
                        onChanged: (text) => _inputID = text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const InputDecoration(
                            alignLabelWithHint: true,
                            // filled: true,
                            // fillColor: Colors.red,
                            isDense: true,
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    strokeAlign:
                                        BorderSide.strokeAlignOutside)),
                            labelText: '이메일',
                            labelStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 52,
                      child: TextField(
                        onChanged: (text) => _inputPW = text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const InputDecoration(
                            alignLabelWithHint: true,
                            // filled: true,
                            // fillColor: Colors.red,
                            isDense: true,
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    strokeAlign:
                                        BorderSide.strokeAlignOutside)),
                            labelText: '비밀번호',
                            labelStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextButton(
                        onPressed: () =>
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => const FindPwPage())),
                        child: const Text('비밀번호를 잊어버리셨나요?')),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        onPressed: handleBtnClick,
                        child: const Text(
                          '로그인',
                          style: btnTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                          child: SizedBox(
                        height: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.outline),
                        ),
                      )),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '다른 방법으로 로그인',
                        style: anotherTextStyle(context),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                          child: SizedBox(
                        height: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.outline),
                        ),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 52,
                    child: OutlinedButton(
                        style: btnOutlineStyle(context),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SvgPicture.asset('assets/')
                            SizedBox(
                              width: 28,
                              height: 28,
                              child: SvgPicture.asset(
                                  'assets/svgs/google_icon.svg'),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Google로 로그인',
                              style: socialBtnTextStyle(context),
                            )
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('계정이 없으세요?'),
                      const SizedBox(
                        width: 8,
                      ),
                      TextButton(
                          onPressed: () =>
                              Navigator.push(context, CupertinoPageRoute(builder: (context) => const JoinPage())),
                          child: const Text(
                            '회원가입 하러가기',
                            style: joinBtnTextStyle,
                          ))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
