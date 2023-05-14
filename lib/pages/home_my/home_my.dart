import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:plancation/modules/firebase_firestore.dart';
import 'package:plancation/modules/firebase_login.dart';
import 'package:plancation/modules/firebase_storage.dart';
import 'package:plancation/modules/image_picker.dart';
import 'package:plancation/pages/login_main/login_main.dart';

class HomeMyComponent extends StatefulWidget {
  const HomeMyComponent({super.key});

  @override
  _HomeMyComponent createState() => _HomeMyComponent();
}

class _HomeMyComponent extends State<HomeMyComponent> {
  bool isNameChanged = false;
  bool isPhotoChanged = false;

  String userName = AuthManage().getUser()!.displayName.toString();
  String userEmail = AuthManage().getUser()!.email.toString();
  String userImage = AuthManage().getUser()!.photoURL.toString();

  String? changedUserName;
  File? userImageFile;

  late final TextEditingController nameFieldController =
      TextEditingController(text: userName);
  late final TextEditingController emailFieldController =
      TextEditingController(text: userEmail);

  nameChanged(String name) {
    setState(() {
      changedUserName = name;
    });

    if (name == userName) {
      setState(() {
        isNameChanged = false;
      });
    } else {
      setState(() {
        isNameChanged = true;
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

    AuthManage().updateProfileName(changedUserName!);
    AuthManage().updateProfileUrl(downloadURL);

    StoreManage().updateUserName(changedUserName!);
    StoreManage().updateUserImage(downloadURL);

    setState(() {
      userName = nameFieldController.text;
      userImage = downloadURL;

      isNameChanged = false;
      isPhotoChanged = false;
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: SafeArea(
              child: Container(
                color: Theme.of(context).colorScheme.secondary,
                height: 60,
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
          body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 172,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              alignment: Alignment.center,
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
                                          child: Image.file(userImageFile!,
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.cover),
                                        )
                                            : userImage.isNotEmpty &&
                                            userImage != "null"
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
                                  TextButton(
                                      onPressed: photoChanged,
                                      child: const Text("변경"))
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
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
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 16),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        width: 72,
                                        child: Text("이름",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16)),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: TextField(
                                            textInputAction: TextInputAction.done,
                                            onChanged: nameChanged,
                                            controller: nameFieldController,
                                            decoration: const InputDecoration(
                                                border: InputBorder.none)),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 16),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        width: 72,
                                        child: Text("이메일",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16)),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: TextField(
                                            enabled: false,
                                            controller: emailFieldController,
                                            decoration: const InputDecoration(
                                                border: InputBorder.none)),
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
                              if (mounted) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => const LoginMainPage()),
                                        (_) => false);
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
                              isNameChanged || isPhotoChanged
                                  ? submitEditProfile
                                  : null,
                              child: const Text(
                                '수정 완료',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              )),
                        )
                      ],
                    )
                  ],
                ),
              )
          )
      );
  }
}
