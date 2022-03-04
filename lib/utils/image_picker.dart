import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickImage {
  Future<File> selectImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    final path = File(image.path);
    return path;
  }

  Future<File> captureImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.camera);
    final path = File(image.path);
    return path;
  }
}