import 'dart:ui';

import 'package:flutter/material.dart';

class AppBarStyle {
  double appBarSize = 60;

  TextStyle appBarTitleStyle = const TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );

  Color appBarBackgroundColor(context) {
    return Theme.of(context).colorScheme.secondary;
  }
}