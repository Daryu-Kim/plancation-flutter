import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future<String> updateUserImage(Uint8List file) async {
    try {
      final userID = AuthManage().getUser()?.uid;
      final userImageRef = FirebaseStorage.instance.ref().child("Users/$userID/profile_image.png");
      final credential = await userImageRef.putData(file);
      final downloadURL = await userImageRef.getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      Logger().e(e);
      return "";
    }
  }
}
