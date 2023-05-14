import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:plancation/modules/firebase_firestore.dart';
import 'package:plancation/modules/firebase_login.dart';
import 'package:plancation/modules/firebase_storage.dart';
import 'package:plancation/modules/image_picker.dart';
import 'diary_new.style.dart';

class DiaryNew extends StatefulWidget {
  const DiaryNew({super.key});

  @override
  _DiaryNewState createState() => _DiaryNewState();
}

class _DiaryNewState extends State<DiaryNew> {
  bool isTitleEntered = false;
  bool isContentEntered = false;
  bool isPhotoSelected = false;

  String diaryTitle = "";
  String diaryContent = "";
  File? diaryImageFile;

  late final TextEditingController titleFieldController =
      TextEditingController(text: diaryTitle);
  late final TextEditingController contentFieldController =
      TextEditingController(text: diaryContent);

  titleChanged(String title) {
    diaryTitle = title;
    if (title.isNotEmpty) {
      setState(() {
        isTitleEntered = true;
      });
    } else {
      setState(() {
        isTitleEntered = false;
      });
    }
  }

  contentChanged(String content) {
    diaryContent = content;
    if (content.isNotEmpty) {
      setState(() {
        isContentEntered = true;
      });
    } else {
      setState(() {
        isContentEntered = false;
      });
    }
  }

  Future<void> photoChanged() async {
    File? selectedImage =
        await ImageSelector().getDiaryImage(ImageSource.gallery);
    setState(() {
      isPhotoSelected = true;
      diaryImageFile = selectedImage;
    });
  }

  photoRemoved() {
    diaryImageFile = null;
    setState(() {
      isPhotoSelected = false;
    });
  }

  Future<void> submitNewDiary(context) async {
    String downloadURL = "";
    String postID = await StoreManage()
        .createDiary(diaryTitle, diaryContent);

    if (diaryImageFile != null) {
      downloadURL =
          await StorageManage().uploadDiaryImage(diaryImageFile, postID);
    }

    await StoreManage().updateDiaryImage(postID, downloadURL);
    Navigator.pop(context);
  }

  popBtnClicked() {
    Navigator.pop(context);
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: popBtnClicked,
                    child: const Text(
                      "취소",
                      style:
                          TextStyle(color: CupertinoColors.white, fontSize: 16),
                    )),
                const Text(
                  '글쓰기',
                  style: TextStyle(
                    fontSize: 18,
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextButton(
                    onPressed: isTitleEntered && isContentEntered
                        ? () => submitNewDiary(context)
                        : null,
                    child: const Text(
                      "등록",
                      style:
                          TextStyle(color: CupertinoColors.white, fontSize: 16),
                    ))
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 84,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                      fit: FlexFit.tight,
                      child: TextField(
                        onChanged: titleChanged,
                        controller: titleFieldController,
                        maxLength: 20,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            hintText: "글 제목을 입력해주세요.", labelText: "글 제목"),
                      )),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: photoChanged,
                    onLongPress: photoRemoved,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              style: BorderStyle.solid,
                              width: 2),
                          borderRadius: BorderRadius.circular(8)),
                      child: isPhotoSelected
                          ? diaryImageFile == null
                              ? Icon(Icons.add_a_photo_outlined,
                                  color: Theme.of(context).colorScheme.primary)
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.file(
                                    diaryImageFile!,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ))
                          : Icon(Icons.add_a_photo_outlined,
                              color: Theme.of(context).colorScheme.primary),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 160,
                child: TextField(
                  onChanged: contentChanged,
                  controller: contentFieldController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: "본문 텍스트를 입력해주세요.",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                            width: 2,
                            style: BorderStyle.solid),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
