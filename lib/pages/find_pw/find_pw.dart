import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plancation/modules/firebase_login.dart';
import 'package:plancation/pages/login/login.dart';

class FindPwPage extends StatefulWidget {
  const FindPwPage({super.key});

  @override
  _FindPwPageState createState() => _FindPwPageState();
}

class _FindPwPageState extends State<FindPwPage> {
  String inputEmail = "";

  Future<void> handleFindPWClick() async {
    await AuthManage().sendPasswordResetEmail(inputEmail, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(168),
        child: AppBar(
            toolbarHeight: 168,
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "비밀번호를",
                        style: TextStyle(
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 23),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "잊으셨나요?",
                        style: TextStyle(
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 23),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 84,
                  height: 84,
                  child: Theme.of(context).brightness == Brightness.light
                      ? SvgPicture.asset('assets/svgs/logo-light-symbol.svg')
                      : SvgPicture.asset('assets/svgs/logo-dark-symbol.svg'),
                )
              ],
            )),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, bottom: 48, left: 24, right: 24),
        child: Column(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "비밀번호를 재설정하려는 계정(이메일)을 입력해 주세요.",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 52,
                    child: TextField(
                      onChanged: (text) => inputEmail = text,
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
                                  strokeAlign: BorderSide.strokeAlignOutside)),
                          labelText: '이메일 주소입력',
                          labelStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 50,
                  child: FilledButton(
                    onPressed: handleFindPWClick,
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "이메일 전송",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
