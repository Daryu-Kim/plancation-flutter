import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:plancation/modules/firebase_login.dart';

class StoreManage {
  Future<bool> createUser(String uid, String name, BuildContext context) async {
    try {
      final credential = await FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .set({'userID': uid});
      final updateCredential = await FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .update({'userName': name});
      final calendar =
          await FirebaseFirestore.instance.collection("Calendars").add({
        'users': [uid]
      });
    } catch (e) {
      Logger().e(e);
      return false;
    }
    return true;
  }

  Future<bool> updateUserImage(String path) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(AuthManage().getUser()?.uid.toString())
          .update({'userImagePath': path});
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  Future<bool> updateUserName(String name) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(AuthManage().getUser()?.uid.toString())
          .update({'userName': name});
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }
}
