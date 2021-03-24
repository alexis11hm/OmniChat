
import 'dart:io';

import 'package:chat_real_time_app/data/image_picker_repository.dart';
import 'package:chat_real_time_app/data/stream_api_repository.dart';
import 'package:chat_real_time_app/domain/models/chat_user.dart';
import 'package:chat_real_time_app/domain/usecases/profile_sign_in_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileState{
  const ProfileState(this.file, {this.success = false, this.loading});
  final File file;
  final bool success;
  final bool loading;
}

class ProfileVerifyCubit extends Cubit<ProfileState>{

  ProfileVerifyCubit(this._imagePickerRepository,this._profileSignInUseCase) : super(ProfileState(null));

  final nameController = TextEditingController();
  final ImagePickerRepository _imagePickerRepository;
  final ProfileSignInUseCase _profileSignInUseCase;

  void startChatting() async {
    emit(ProfileState(state.file, loading: true));
    final file = state.file;
    final name = nameController.text;
    await _profileSignInUseCase.verify(ProfileInput(
      imageFile: file,
      name: name
    ));
    emit(ProfileState(file, success: true, loading: false));
  }

  void pickImage() async{
    final image = await _imagePickerRepository.pickImage();
    emit(ProfileState(image));
  }

  

}