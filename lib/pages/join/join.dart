import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plancation/styles/body_style.dart';
import 'package:word_break_text/word_break_text.dart';
import 'join.style.dart';
import '../../modules/another.dart';
import '../../modules/firebase_login.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});

  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  String _inputID = "";
  String _inputPW = "";
  String _inputPWC = "";
  String _inputName = "";
  bool isVisiblePassword = false;

  handleJoinBtn() {
    if (_inputID.isNotEmpty) {
      if (isValidEmailFormat(_inputID)) {
        if (_inputName.isNotEmpty) {
          if (_inputPW.isNotEmpty) {
            if (_inputPWC.isNotEmpty) {
              if (_inputPW == _inputPWC) {
                AuthManage()
                    .createUser(_inputID, _inputPW, _inputName, context);
              } else {
                errorSnackBar(context, "비밀번호가 일치하지 않습니다!");
              }
            } else {
              errorSnackBar(context, "비밀번호 확인을 입력해주세요!");
            }
          } else {
            errorSnackBar(context, "비밀번호를 입력해주세요!");
          }
        } else {
          errorSnackBar(context, "이름을 입력해주세요!");
        }
      } else {
        errorSnackBar(context, "이메일 형식이 맞지 않습니다!");
      }
    } else {
      errorSnackBar(context, "이메일을 입력해주세요!");
    }
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
                      "Plancation",
                      style: TextStyle(
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "회원가입",
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
          padding: BodyStyle().bodyPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  children: [
                    SizedBox(
                      height: 52,
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onChanged: (text) {
                          setState(() {
                            _inputID = text;
                          });
                        },
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
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onChanged: (text) {
                          setState(() {
                            _inputName = text;
                          });
                        },
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
                            labelText: '이름',
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
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
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
                            isDense: true,
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    strokeAlign: BorderSide.strokeAlignOutside)),
                            labelText: '비밀번호',
                            labelStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        onChanged: (text) {
                          setState(() {
                            _inputPW = text;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 52,
                      child: TextField(
                        obscureText: !isVisiblePassword,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
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
                            isDense: true,
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    strokeAlign: BorderSide.strokeAlignOutside)),
                            labelText: '비밀번호 확인',
                            labelStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        onChanged: (text) {
                          setState(() {
                            _inputPWC = text;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  const WordBreakText(
                    '가입하기 버튼을 누르면, 플랜케이션의 서비스 이용약관과 개인정보처리방침 를 읽고 동의했음으로 간주합니다.',
                    wrapAlignment: WrapAlignment.center,
                    spacingByWrap: true,
                    spacing: 2,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 52,
                    child: FilledButton(
                        onPressed: () => handleJoinBtn(),
                        child: const SizedBox(
                          width: double.infinity,
                          child: Text(
                            '가입하기',
                            style: btnTextStyle,
                            textAlign: TextAlign.center,
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
