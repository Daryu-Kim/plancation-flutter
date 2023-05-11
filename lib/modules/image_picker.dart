import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector {
  Future<File?> getImage(ImageSource source) async {
    /// getImage(ImageSource.camera) && getImage(ImageSource.gallery)
    XFile? image = await ImagePicker().pickImage(source: source);
    File croppedImage = (await ImageCropper().cropImage(
        sourcePath: image!.path,
      cropStyle: CropStyle.rectangle,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressFormat: ImageCompressFormat.png,
      maxWidth: 128,
      maxHeight: 128,
      compressQuality: 50
    )) as File;
    return croppedImage;
  }
}