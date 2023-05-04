import 'package:flutter/material.dart';

welcomeTextStyle(context) {
  var welcomeTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: Theme.of(context).colorScheme.primary);
  return welcomeTextStyle;
}

btnOutlineStyle(context) {
  var btnOutlineStyle = ButtonStyle(
      side: MaterialStateProperty.all(
          BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)));
  return btnOutlineStyle;
}

const btnTextStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 20);

termsTextStyle(context) {
  var termsTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      fontFamily: 'Pretendard',
      color: Theme.of(context).colorScheme.primary);
  return termsTextStyle;
}
