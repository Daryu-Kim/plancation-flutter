import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:plancation/modules/another.dart';
import 'package:plancation/modules/firebase_login.dart';
import 'package:plancation/pages/find_pw/find_pw.dart';
import 'package:plancation/pages/home.dart';
import 'package:plancation/pages/join/join.dart';
import 'package:plancation/styles/body_style.dart';
import '../../modules/firebase_firestore.dart';
import 'login.style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _inputID = "";
  String _inputPW = "";
  bool isVisiblePassword = false;

  handleBtnClick() {
    AuthManage().signIn(_inputID, _inputPW, context);
  }

  Future<bool> googleLoginClick(context) async {
    try {
      await AuthManage().signInWithGoogle();
      if (AuthManage().getUser() != null) {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(AuthManage().getUser()!.uid)
            .get()
            .then((value) async {
          if (!value.exists) {
            await StoreManage().createUser(AuthManage().getUser()!.uid,
                AuthManage().getUser()!.displayName!, context);
          }
          if (mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(
                    builder: (context) =>
                    const HomePage()),
                    (_) => false);
          }

        });
      }
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Container(
            alignment: AlignmentDirectional.center,
            height: setBodyHeightNotIncludeAll(context),
            padding: BodyStyle().bodyPadding,
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
                          child: Theme.of(context).brightness ==
                                  Brightness.light
                              ? SvgPicture.asset('assets/svgs/logo-light.svg')
                              : SvgPicture.asset('assets/svgs/logo-dark.svg')),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 52,
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
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
                          obscureText: !isVisiblePassword,
                          onSubmitted: (_) => handleBtnClick(),
                          onChanged: (text) => _inputPW = text,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                              suffixIcon: TextButton(
                                onPressed: () {
                                  setState(() {
                                    isVisiblePassword = !isVisiblePassword;
                                  });
                                },
                                child: Text(isVisiblePassword ? "숨기기" : "표시",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: isVisiblePassword
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .outline)),
                              ),
                              alignLabelWithHint: true,
                              // filled: true,
                              // fillColor: Colors.red,
                              isDense: true,
                              border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside)),
                              labelText: '비밀번호',
                              labelStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const FindPwPage())),
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
                          onPressed: () => googleLoginClick(context),
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
                            onPressed: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const JoinPage())),
                            child: const Text(
                              '회원가입 하러가기',
                              style: joinBtnTextStyle,
                            ))
                      ],
                    )
                  ],
                ),
              ],
            )),
      ),
    ));
  }
}
