

import 'dart:ffi';

import 'package:chat_real_time_app/data/persistent_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _isDarkMode = 'isDarkMode';

class PersistenceStorageImpl extends PersistentStorageRepository{

  @override
  Future<bool> isDarkMode() async{
    final preference = await SharedPreferences.getInstance();
    return preference.getBool(_isDarkMode) ?? false;
  }

  @override
  Future<Void> updateDarkMode(bool isDarkMode) async{
    final preference = await SharedPreferences.getInstance();
    await preference.setBool(_isDarkMode, isDarkMode);
  }

}