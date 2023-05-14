import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:plancation/modules/firebase_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<String> uploadDiaryImage(File? file, String postID) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String calendarID = "";

      if (prefs.getString("selectedCalendarID") != null) {
        calendarID = prefs.getString("selectedCalendarID")!;
      } else {
        calendarID = AuthManage().getUser()!.uid;
      }

      final diaryImageRef = FirebaseStorage.instance
          .ref()
          .child("Calendars/$calendarID/Posts/$postID/diaryImage.png");
      String downloadURL = "";
      await diaryImageRef.putFile(file!);
      downloadURL = await diaryImageRef.getDownloadURL();

      return downloadURL;
    } on FirebaseException catch (e) {
      Logger().e(e);
      return "";
    }
  }

  Future<bool> deleteDiaryImage(String calendarID, String postID) async {
    try {
      final diaryImageRef = FirebaseStorage.instance
          .ref()
          .child("Calendars/$calendarID/Posts/$postID/diaryImage.png");
      await diaryImageRef.delete();
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }
}
