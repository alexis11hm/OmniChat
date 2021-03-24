
import 'package:chat_real_time_app/domain/models/auth_user.dart';

abstract class AuthRepository{
  Future<AuthUser> getAuthUser();
  Future<AuthUser> signIn();
  Future<void> logout();
}