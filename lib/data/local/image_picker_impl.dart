
import 'dart:io';

import 'package:chat_real_time_app/data/image_picker_repository.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerImpl extends ImagePickerRepository{
  @override 
  Future<File> pickImage() async{
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery, maxWidth: 400);
    return File(pickedFile.path);
  }
}