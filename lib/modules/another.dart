import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:plancation/modules/firebase_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isValidEmailFormat(email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

errorSnackBar(BuildContext context, String msg) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.error)),
    duration: const Duration(milliseconds: 1500),
    backgroundColor: Theme.of(context).colorScheme.errorContainer,
    behavior: SnackBarBehavior.fixed,
  ));
}

infoSnackBar(BuildContext context, String msg) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.inverseSurface)),
    duration: const Duration(milliseconds: 1500),
    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
    behavior: SnackBarBehavior.fixed,
  ));
}

loadingSnackbar(BuildContext context, String msg) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
    duration: Duration.zero,
    behavior: SnackBarBehavior.fixed,
  ));
}

dismissSnackBar(BuildContext context) {
  return ScaffoldMessenger.of(context).hideCurrentSnackBar();
}

Future<String> getCalendarID() async{
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String calendarID = "";

    if (prefs.getString("selectedCalendarID") != null) {
      calendarID = prefs.getString("selectedCalendarID")!;
    } else {
      calendarID = AuthManage().getUser()!.uid;
    }

    return calendarID;
  } catch (e) {
    Logger().e(e);
    return "";
  }
}