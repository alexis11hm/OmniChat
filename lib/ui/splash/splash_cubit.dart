import 'package:chat_real_time_app/domain/exceptions/auth_exception.dart';
import 'package:chat_real_time_app/domain/usecases/login_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SplashState { none, existingUser, new_user }

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._loginUseCase) : super(SplashState.none);

  final LoginUseCase _loginUseCase;

  void init() async {
    try {
      final result = await _loginUseCase.validateLogin();
      if (result) {
        emit(SplashState.existingUser);
      }
    } on AuthException catch (ex) {
      if (ex.error == AuthErrorCode.not_auth) {
        emit(SplashState.none);
      } else {
        emit(SplashState.new_user);
      }
    }
  }
}
