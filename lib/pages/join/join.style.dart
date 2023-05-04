import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const btnTextStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 18);
btnOutlineStyle(context) {
  var btnOutlineStyle = ButtonStyle(
      side: MaterialStateProperty.all(
          BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)));
  return btnOutlineStyle;
}

socialBtnTextStyle(context) {
  var socialBtnTextStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: Theme.of(context).colorScheme.inverseSurface);
  return socialBtnTextStyle;
}

anotherTextStyle(context) {
  var anotherTextStyle = TextStyle(
      fontWeight: FontWeight.w700,
      color: Theme.of(context).colorScheme.outline);
  return anotherTextStyle;
}

const joinBtnTextStyle = TextStyle(
  fontWeight: FontWeight.w700,
);
