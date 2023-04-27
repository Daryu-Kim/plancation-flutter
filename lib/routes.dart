import 'package:flutter/cupertino.dart';

import 'pages/login/login.dart';
import 'pages/join/join.dart';
import 'pages/login_main/login_main.dart';
import 'pages/home.dart';

final routes = {
  '/': (BuildContext context) => LoginMainPage(),
  '/join': (BuildContext context) => JoinPage(),
  '/home': (BuildContext context) => HomePage(),
  '/login': (BuildContext context) => LoginPage(),
};