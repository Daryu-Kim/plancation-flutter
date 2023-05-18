import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:plancation/modules/firebase_firestore.dart';
import 'package:plancation/modules/firebase_storage.dart';
import 'package:plancation/modules/image_picker.dart';

class DiaryForm extends StatefulWidget {
  const DiaryForm({
    super.key,
    required this.appBarTitle,
    required this.appBarBtn,
    required this.postTitle,
    required this.postContent,
    required this.postImagePath,
    required this.postID,
  });

  final String appBarTitle,
      appBarBtn,
      postTitle,
      postContent,
      postID;
  final String? postImagePath;

  @override
  _DiaryFormState createState() => _DiaryFormState();
}

class _DiaryFormState extends State<DiaryForm> {
  late bool isTitleEntered = widget.postTitle.isNotEmpty ? true : false;
  late bool isContentEntered = widget.postContent.isNotEmpty ? true : false;
  late bool isPhotoSelected = widget.postImagePath != null ? true : false;

  late String diaryTitle = widget.postTitle;
  late String diaryContent = widget.postContent;
  late String? diaryImagePath = widget.postImagePath;
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
      diaryImagePath = "";
      diaryImageFile = selectedImage;
    });
  }

  photoRemoved() {
    diaryImageFile = null;
    diaryImagePath = "";
    setState(() {
      isPhotoSelected = false;
    });
  }

  Future<void> submitDiary(context) async {
    String postID = widget.postID.isNotEmpty
        ? await StoreManage()
            .modifyDiary(widget.postID, diaryTitle, diaryContent)
        : await StoreManage().createDiary(diaryTitle, diaryContent);

    if (diaryImageFile != null) {
      diaryImagePath =
          await StorageManage().uploadDiaryImage(diaryImageFile, postID);
    }

    await StoreManage().updateDiaryImage(postID, diaryImagePath);

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
                Text(
                  widget.appBarTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextButton(
                    onPressed: isTitleEntered && isContentEntered
                        ? () => submitDiary(context)
                        : null,
                    child: Text(
                      widget.appBarBtn,
                      style: const TextStyle(
                          color: CupertinoColors.white, fontSize: 16),
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
                          ? diaryImagePath != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    diaryImagePath!,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ))
                              : diaryImageFile == null
                                  ? Icon(Icons.add_a_photo_outlined,
                                      color:
                                          Theme.of(context).colorScheme.primary)
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
