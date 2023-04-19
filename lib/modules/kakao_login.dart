import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:logger/logger.dart';

class Kakao {
  void signInWithKakao() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();
      Logger().d("로그인 성공");

      final url = Uri.https('kapi.kakao.com', '/v2/user/me');

      final response = await get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );

      final profileInfo = json.decode(response.body);
      Logger().d(profileInfo.toString());
    } catch (error) {
      Logger().e('카카오톡으로 로그인 실패 $error');
    }
  }

  void signOutKakao() async {
    await UserApi.instance.logout();
  }
}
