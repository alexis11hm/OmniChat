import 'package:chat_real_time_app/navigator_utils.dart';
import 'package:chat_real_time_app/ui/home/home_view.dart';
import 'package:chat_real_time_app/ui/profile_verify/profile_verify_view.dart';
import 'package:chat_real_time_app/ui/sign_in/sign_in_view.dart';
import 'package:chat_real_time_app/ui/splash/initial_background_view.dart';
import 'package:chat_real_time_app/ui/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(context.read())..init(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, snapshot) {
          if (snapshot == SplashState.none) {
            pushAndReplaceToPage(context, SignInView());
          } else if (snapshot == SplashState.existingUser) {
            pushAndReplaceToPage(context, HomeView());
          } else {
            pushAndReplaceToPage(context, ProfileVerifyView());
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              InitialBackgroundView(),
              Center(
                child: Hero(
                    tag: 'logo_hero',
                    child: Image.asset('assets/logo.png', height: 100)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
