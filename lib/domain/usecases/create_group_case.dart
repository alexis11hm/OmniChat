import 'dart:io';

import 'package:chat_real_time_app/data/stream_api_repository.dart';
import 'package:chat_real_time_app/data/upload_storage_repository.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:uuid/uuid.dart';

class CreateGroupInput {
  CreateGroupInput({this.imageFile, this.name, this.members});

  final File imageFile;
  final String name;
  final List<String> members;
}

class CreateGroupUseCase {
  CreateGroupUseCase(this._streamApiRepository, this._uploadStorageRepository);

  final UploadStorageRepository _uploadStorageRepository;
  final StreamApiRepository _streamApiRepository;

  Future<Channel> createGroup(CreateGroupInput input) async {
    final channelId = Uuid().v4();
    String image;
    List<String> path = input.imageFile.path.split('/');
    String imagePath = path.toList().elementAt(path.length-1);
    print(imagePath);
    if (input.imageFile != null) {
      image = await _uploadStorageRepository.uploadPhoto(
          input.imageFile, 'channels/$imagePath');
    }

    final channel = await _streamApiRepository
        .createGroupChat(channelId, input.name, input.members, image: image);
    return channel;
  }
}
