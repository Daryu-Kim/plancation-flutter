import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:plancation/modules/firebase_login.dart';

class StorageManage {
  Future<String> uploadUserImage(File? file) async {
    Logger().e("Type is $file");
    try {
      final userID = AuthManage().getUser()?.uid;
      final userImageRef = FirebaseStorage.instance
          .ref()
          .child("Users/$userID/profile_image.png");
      String downloadURL = "";
      if (file == null) {
        await userImageRef.delete();
      } else {
        await userImageRef.putFile(file);
        downloadURL = await userImageRef.getDownloadURL();
      }

      return downloadURL;
    } on FirebaseException catch (e) {
      Logger().e(e);
      return "";
    }
  }

  Future<void> removeUserImage() async {
    try {
      final userID = AuthManage().getUser()?.uid;
      final userImageRef = FirebaseStorage.instance
          .ref()
          .child("Users/$userID/profile_image.png");
      await userImageRef.delete();
    } on FirebaseException catch (e) {
      Logger().e(e);
    }
  }
}
