import 'package:flutter/material.dart';

welcomeTextStyle(context) {
  var _welcomeTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: Theme.of(context).colorScheme.primary);
  return _welcomeTextStyle;
}

btnOutlineStyle(context) {
  var _btnOutlineStyle = ButtonStyle(
      side: MaterialStateProperty.all(
          BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)));
  return _btnOutlineStyle;
}

const btnTextStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 20);

termsTextStyle(context) {
  var _termsTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      fontFamily: 'Pretendard',
      color: Theme.of(context).colorScheme.primary);
  return _termsTextStyle;
}
