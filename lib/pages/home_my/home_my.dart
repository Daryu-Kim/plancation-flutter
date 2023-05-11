import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:plancation/modules/firebase_firestore.dart';
import 'package:plancation/modules/firebase_login.dart';
import 'package:plancation/modules/firebase_storage.dart';
import 'package:plancation/modules/image_picker.dart';

class HomeMyComponent extends StatefulWidget {
  const HomeMyComponent({super.key});

  @override
  _HomeMyComponent createState() => _HomeMyComponent();
}

class _HomeMyComponent extends State<HomeMyComponent> {
  bool isNameChanged = false;
  bool isEmailChanged = false;
  bool isPhotoChanged = false;

  String userName = AuthManage().getUser()!.displayName.toString();
  String userEmail = AuthManage().getUser()!.email.toString();
  String userImage = AuthManage().getUser()!.photoURL.toString();
  File? userImageFile;

  late final TextEditingController nameFieldController =
      TextEditingController(text: userName);
  late final TextEditingController emailFieldController =
      TextEditingController(text: userEmail);

  nameChanged(String name) {
    if (name == userName) {
      nameFieldController.text = name;
      nameFieldController.selection = TextSelection.fromPosition(
          TextPosition(offset: nameFieldController.text.length));
      setState(() {
        isNameChanged = false;
      });
    } else {
      nameFieldController.text = name;
      nameFieldController.selection = TextSelection.fromPosition(
          TextPosition(offset: nameFieldController.text.length));
      setState(() {
        isNameChanged = true;
      });
    }
  }

  emailChanged(String email) {
    if (email == userEmail) {
      emailFieldController.text = email;
      emailFieldController.selection = TextSelection.fromPosition(
          TextPosition(offset: emailFieldController.text.length));
      setState(() {
        isEmailChanged = false;
      });
    } else {
      emailFieldController.text = email;
      emailFieldController.selection = TextSelection.fromPosition(
          TextPosition(offset: emailFieldController.text.length));
      setState(() {
        isEmailChanged = true;
      });
    }
  }

  Future<void> photoChanged() async {
    File? selectedImage = await ImageSelector().getImage(ImageSource.gallery);
    Logger().w(selectedImage);
    setState(() {
      isPhotoChanged = true;
      userImageFile = selectedImage;
    });
  }

  Future<void> submitEditProfile() async {
    String downloadURL = "";
    if (userImageFile != null) {
      downloadURL = await StorageManage().uploadUserImage(userImageFile);
    } else {
      await StorageManage().removeUserImage();
    }

    AuthManage().updateProfileName(nameFieldController.text);
    AuthManage().updateProfileEmail(emailFieldController.text);
    AuthManage().updateProfileUrl(downloadURL);

    StoreManage().updateUserName(nameFieldController.text);
    StoreManage().updateUserImage(downloadURL);

    setState(() {
      userName = nameFieldController.text;
      userEmail = emailFieldController.text;
      userImage = downloadURL;

      isNameChanged = false;
      isEmailChanged = false;
      isPhotoChanged = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: SafeArea(
          child: Container(
            color: Theme.of(context).colorScheme.secondary,
            height: 72,
            child: const Center(
              child: Text(
                '내 계정',
                style: TextStyle(
                  fontSize: 18,
                  color: CupertinoColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
              child: Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Theme.of(context).colorScheme.primary,
                                        child: isPhotoChanged
                                            ? userImageFile == null
                                                ? Text(
                                                    userName.length < 3
                                                        ? userName
                                                        : userName.substring(0, 3),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .background),
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(100),
                                                    child: Image.file(
                                                        userImageFile!,
                                                        height: 80,
                                                        width: 80,
                                                        fit: BoxFit.cover),
                                                  )
                                            : userImage.isNotEmpty && userImage != "null"
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(100),
                                                    child: Image.network(
                                                        userImage.toString(),
                                                        height: 80,
                                                        width: 80,
                                                        fit: BoxFit.cover),
                                                  )
                                                : Text(
                                                    userName.length < 3
                                                        ? userName
                                                        : userName.substring(0, 3),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .background),
                                                  ),
                                      )),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextButton(
                                      onPressed: photoChanged, child: Text("변경"))
                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 16),
                                child: Text(
                                  "가입정보",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).colorScheme.primary),
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 72,
                                      child: Text("이름",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16)),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                          onChanged: nameChanged,
                                          controller: nameFieldController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none)),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 72,
                                      child: Text("이메일",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16)),
                                    ),
                                    Flexible(
                                      child: TextField(
                                          onChanged: emailChanged,
                                          controller: emailFieldController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none)),
                                      flex: 1,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () async {
                            await AuthManage().signOut();
                            if (this.mounted) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (_) => false);
                            }
                          },
                          child: const Text(
                            '로그아웃',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: FilledButton(
                            onPressed:
                                isNameChanged || isEmailChanged || isPhotoChanged
                                    ? () => submitEditProfile()
                                    : null,
                            child: Text(
                              '수정 완료',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
      ),
    );
  }
}
