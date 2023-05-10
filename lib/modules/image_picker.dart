import 'package:image_picker_web/image_picker_web.dart';

class ImageSelector {
  getImage() {
    /// getImage(ImageSource.camera) && getImage(ImageSource.gallery)
    final image = ImagePickerWeb.getImageAsBytes();
    return image;
  }
}