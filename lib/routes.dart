import 'package:flutter/cupertino.dart';

import 'pages/login/login.dart';
import 'pages/join/join.dart';
import 'pages/login_main/login_main.dart';
import 'pages/home.dart';
import 'pages/find_pw/find_pw.dart';

final routes = {
  '/': (BuildContext context) => const LoginMainPage(),
  '/join': (BuildContext context) => const JoinPage(),
  '/home': (BuildContext context) => const HomePage(),
  '/login': (BuildContext context) => const LoginPage(),
  '/find_pw': (BuildContext context) => const FindPwPage(),
};
