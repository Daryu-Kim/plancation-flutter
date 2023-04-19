import 'package:image_picker/image_picker.dart';

class ImageSelector {
  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    /// getImage(ImageSource.camera) && getImage(ImageSource.gallery)
    final image = await picker.pickImage(source: imageSource);
    return image;
  }
}