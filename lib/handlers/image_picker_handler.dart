import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerHandler {
  getImages() async {
    List<XFile> images = await ImagePicker().pickMultiImage();
    List<File> imagesList = images.map((e) => File(e.path)).toList();
    /* File pickedFile = File(
        (await ImagePicker().pickImage(source: type ?? ImageSource.gallery))!
            .path); */
    return imagesList;
  }
getSingleImage() async {
    File pickedFile =
        File((await ImagePicker().pickImage(source: ImageSource.gallery))!.path);

    return pickedFile;
  }
  getCameraImage() async {
    File pickedFile =
        File((await ImagePicker().pickImage(source: ImageSource.camera))!.path);

    return pickedFile;
  }
}
