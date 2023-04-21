import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'modules/color_schemes.g.dart';
import 'modules/firebase_options.dart';
import 'routes.dart';

void main() => initializeDateFormatting().then((value) => runApp(const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    KakaoSdk.init(nativeAppKey: '832accb12e772f529ef4b1a1e529e8c9', javaScriptAppKey: 'fb8af3ca919e510985f8fbefa2599e8e');
    Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) => print(value));

    return MaterialApp(
      title: 'Plancation',
      theme: ThemeData(colorScheme: lightColorScheme, useMaterial3: true, fontFamily: 'Pretendard'),
      darkTheme: ThemeData(colorScheme: darkColorScheme, useMaterial3: true, fontFamily: 'Pretendard'),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}