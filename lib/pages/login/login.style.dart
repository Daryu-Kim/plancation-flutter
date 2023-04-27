import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const btnTextStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 18);
btnOutlineStyle(context) {
  var _btnOutlineStyle = ButtonStyle(
      side: MaterialStateProperty.all(
          BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)));
  return _btnOutlineStyle;
}

socialBtnTextStyle(context) {
  var _socialBtnTextStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 18,
      color: Theme.of(context).colorScheme.inverseSurface);
  return _socialBtnTextStyle;
}
anotherTextStyle(context) {
  var _anotherTextStyle = TextStyle(
      fontWeight: FontWeight.w700,
      color: Theme.of(context).colorScheme.outline
  );
  return _anotherTextStyle;
}

const joinBtnTextStyle = TextStyle(
  fontWeight: FontWeight.w700,
);