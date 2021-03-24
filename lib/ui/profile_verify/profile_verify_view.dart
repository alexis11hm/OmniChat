import 'package:chat_real_time_app/navigator_utils.dart';
import 'package:chat_real_time_app/ui/common/avatar_image_view.dart';
import 'package:chat_real_time_app/ui/common/loading_view.dart';
import 'package:chat_real_time_app/ui/home/home_view.dart';
import 'package:chat_real_time_app/ui/profile_verify/profile_verify_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileVerifyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileVerifyCubit(context.read(), context.read()),
      child: BlocConsumer<ProfileVerifyCubit, ProfileState>(
          listener: (context, snapshot) {
        if (snapshot.success) {
          pushAndReplaceToPage(context, HomeView());
        }
      }, builder: (context, snapshot) {
        //Refresh the pho
        return LoadingView(
          isLoading: snapshot?.loading ?? false,
          child: Scaffold(
            backgroundColor: Theme.of(context).canvasColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Verify yout identity',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  AvatarImageView(
                    onTap: () {
                      context.read<ProfileVerifyCubit>().pickImage();
                    },
                    child: snapshot.file != null
                        ? Image.file(snapshot.file, fit: BoxFit.cover)
                        : Icon(Icons.person_outline,
                            size: 100, color: Colors.grey[400]),
                  ),
                  Text(
                    'Your name',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    child: TextField(
                      controller:
                          context.read<ProfileVerifyCubit>().nameController,
                      decoration: InputDecoration(
                          fillColor: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor,
                          hintText: 'Or just how people now you',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey[400]),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none),
                    ),
                  ),
                  Hero(
                    tag: 'home_hero',
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Theme.of(context).accentColor,
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          child: Text('Start chatting now',
                              style: TextStyle(color: Colors.white)),
                        ),
                        onTap: () {
                          context.read<ProfileVerifyCubit>().startChatting();
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
