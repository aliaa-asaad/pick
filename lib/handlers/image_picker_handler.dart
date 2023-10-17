import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerHandler {
  getImage(ImageSource? type) async {
    File pickedFile = File(
        (await ImagePicker().pickImage(source: type ?? ImageSource.gallery))!
            .path);

    return pickedFile;
  }
}
