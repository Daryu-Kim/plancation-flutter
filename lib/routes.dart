import 'package:flutter/cupertino.dart';

import 'pages/login.dart';
import 'pages/join.dart';
import 'pages/login_main.dart';
import 'pages/home.dart';

final routes = {
  '/': (BuildContext context) => LoginMainPage(),
  '/join': (BuildContext context) => JoinPage(),
  '/home': (BuildContext context) => HomePage(),
};