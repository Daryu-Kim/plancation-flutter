import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:word_break_text/word_break_text.dart';

class LoginMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 36, right: 36, top: 24, bottom: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Column(
              children: [
                // 로고
                SizedBox(
                  width: 216,
                  height: 216,
                  child: Theme.of(context).brightness == Brightness.light
                      ? Container(
                          child: SvgPicture.asset('assets/svgs/logo-light.svg'),
                        )
                      : Container(
                          child: SvgPicture.asset('assets/svgs/logo-dark.svg'),
                        ),
                ),
                SizedBox(height: 36),
                // 로그인 / 가입 버튼
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: const GradientBoxBorder(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFFFBACDB), Color(0xFF763CF0)],
                              ),
                              width: 2,
                            )
                        ),
                        child: MaterialButton(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(8)
                              )
                          ),
                          onPressed: () => Navigator.pushNamed(context, '/join'),
                          child: const Text(
                            '가입',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFFBACDB), Color(0xFF763CF0)],
                          )
                        ),
                        child: MaterialButton(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8)
                            )
                          ),
                          onPressed: () {},
                          child: const Text(
                            '로그인',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                      // child: FilledButton(
                      //   onPressed: () {},
                      //   child: const Text(
                      //     '로그인',
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.w900, fontSize: 14),
                      //   ),
                      // ),
                    ),
                  ],
                )
              ],
            ),
            Container(
              child: const WordBreakText(
                '위의 선택지 중 한개를 누름으로서, '
                '플랜케이션의 서비스 이용 약관과 개인정보처리방침에 '
                '동의한 것으로 간주합니다.',
                wrapAlignment: WrapAlignment.center,
                spacingByWrap: true,
                spacing: 2,
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 12, fontFamily: 'Pretendard'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
