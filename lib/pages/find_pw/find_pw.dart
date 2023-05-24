import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plancation/modules/another.dart';
import 'package:plancation/modules/firebase_login.dart';
import 'package:plancation/styles/body_style.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(168),
        child: SafeArea(
          child: Container(
            height: 168,
            color: Theme.of(context).colorScheme.secondary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "비밀번호를",
                      style: TextStyle(
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "잊으셨나요?",
                      style: TextStyle(
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
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
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: setBodyHeightIncludeBigAppBar(context),
          padding:BodyStyle().bodyPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "비밀번호를 재설정하려는 계정(이메일)을 입력해 주세요.",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color:
                            Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(
                    height: 48,
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
                                  strokeAlign:
                                      BorderSide.strokeAlignOutside)),
                          labelText: '이메일 주소입력',
                          labelStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 52,
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
          ),
        ),
      ),
    );
  }
}
