import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector {
  Future<File?> getImage(ImageSource source) async {
    /// getImage(ImageSource.camera) && getImage(ImageSource.gallery)
    XFile? image = await ImagePicker().pickImage(source: source);
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: image!.path,
      cropStyle: CropStyle.rectangle,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressFormat: ImageCompressFormat.png,
      maxWidth: 128,
      maxHeight: 128,
    );
    File resultImage = File(croppedImage!.path);
    return resultImage;
  }

  Future<File?> getDiaryImage(ImageSource source) async {
    /// getImage(ImageSource.camera) && getImage(ImageSource.gallery)
    XFile? image = await ImagePicker().pickImage(source: source);
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: image!.path,
      cropStyle: CropStyle.rectangle,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressFormat: ImageCompressFormat.png,
      maxWidth: 512,
      maxHeight: 512,
    );
    File resultImage = File(croppedImage!.path);
    return resultImage;
  }
}