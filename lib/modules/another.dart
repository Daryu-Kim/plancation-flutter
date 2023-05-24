import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:plancation/modules/firebase_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

isValidEmailFormat(email) {
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

submitSnackBar(BuildContext context, String msg) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: CupertinoColors.white)),
    duration: const Duration(milliseconds: 1500),
    backgroundColor: Colors.green,
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

dismissSnackBar(BuildContext context) async {
  return ScaffoldMessenger.of(context).hideCurrentSnackBar();
}

Future<String> getCalendarID() async {
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

setBodyHeightIncludeBNB(BuildContext context) {
  if (Platform.isAndroid) {
    return MediaQuery.of(context).size.height - 148;
  } else if (Platform.isIOS) {
    return MediaQuery.of(context).size.height - 168;
  } else {
    return null;
  }
}

setBodyHeightNotIncludeBNB(BuildContext context) {
  if (Platform.isAndroid) {
    return MediaQuery.of(context).size.height - 84;
  } else if (Platform.isIOS) {
    return MediaQuery.of(context).size.height - 104;
  } else {
    return null;
  }
}

setBodyHeightNotIncludeAll(BuildContext context) {
  if (Platform.isAndroid) {
    return MediaQuery.of(context).size.height - 24;
  } else if (Platform.isIOS) {
    return MediaQuery.of(context).size.height - 44;
  } else {
    return null;
  }
}

setBodyHeightIncludeBigAppBar(BuildContext context) {
  if (Platform.isAndroid) {
    return MediaQuery.of(context).size.height - 192;
  } else if (Platform.isIOS) {
    return MediaQuery.of(context).size.height - 212;
  } else {
    return null;
  }
}
