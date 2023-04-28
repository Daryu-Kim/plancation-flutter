import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class StoreManage {
  Future<bool> createUser(String uid, String name, BuildContext context) async{
    try {
      final credential = await FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .set({
        'userID': uid
      });
      final updateCredential = await FirebaseFirestore.instance
      .collection("Users")
      .doc(uid)
      .update({
        'userName': name
      });
      final calendar = await FirebaseFirestore.instance
      .collection("Calendars")
      .add({
        'users': [uid]
      });
    } catch (e) {
      Logger().e(e);
      return false;
    }
    return true;
  }
}