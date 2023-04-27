import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class StoreManage {
  Future<bool> createUser(String uid, BuildContext context) async{
    try {
      final credential = await FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .set({
        'userID': uid
      });
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      Logger().e(e);
      return false;
    }
    return true;
  }
}