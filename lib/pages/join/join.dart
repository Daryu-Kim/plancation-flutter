import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:word_break_text/word_break_text.dart';
import 'join.style.dart';

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(168),
          child: AppBar(
              toolbarHeight: 168,
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Theme
                  .of(context)
                  .colorScheme
                  .primary,
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Plancation", style: TextStyle(
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24),),
                        SizedBox(height: 12,),
                        Text("회원가입", style: TextStyle(
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24),),
                      ],
                    ),
                    SizedBox(
                      width: 128,
                      height: 128,
                      child: Theme
                          .of(context)
                          .brightness == Brightness.light
                          ? SvgPicture.asset('assets/svgs/logo-light.svg')
                          : SvgPicture.asset('assets/svgs/logo-dark.svg'),
                    )
                  ],
                ),
              )
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 8, bottom: 48, left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  children: [
                    SizedBox(
                      height: 52,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
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
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 52,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
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
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 52,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            // filled: true,
                            // fillColor: Colors.red,
                            isDense: true,
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    strokeAlign:
                                    BorderSide.strokeAlignOutside)),
                            labelText: '비밀번호 확인',
                            labelStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  WordBreakText(
                      '가입하기 버튼을 누르면, 플랜케이션의 서비스 이용약관과 개인정보처리방침 를 읽고 동의했음으로 간주합니다.',
                      wrapAlignment: WrapAlignment.center,
                      spacingByWrap: true,
                      spacing: 2,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 52,
                    child: FilledButton(
                        onPressed: () {},
                        child: SizedBox(
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
    );
  }
}