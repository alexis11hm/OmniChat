

import 'dart:ffi';

import 'package:chat_real_time_app/data/persistent_storage_repository.dart';

class PersistenceStorageLocalImpl extends PersistentStorageRepository{

  @override
  Future<bool> isDarkMode() async{
    await Future.delayed(const Duration(milliseconds: 50));
    return false;
  }

  @override
  Future<Void> updateDarkMode(bool isDarkMode) async{
    await Future.delayed(const Duration(milliseconds: 50));
    return null;
  }

}