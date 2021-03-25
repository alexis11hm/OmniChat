import 'package:chat_real_time_app/navigator_utils.dart';
import 'package:chat_real_time_app/ui/common/avatar_image_view.dart';
import 'package:chat_real_time_app/ui/common/loading_view.dart';
import 'package:chat_real_time_app/ui/home/chat/chat_view.dart';
import 'package:chat_real_time_app/ui/home/chat/selection/friends_selection_cubit.dart';
import 'package:chat_real_time_app/ui/home/chat/selection/group_selection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class GroupSelectionView extends StatelessWidget {
  GroupSelectionView(this.selectedUsers);

  final List<ChatUserState> selectedUsers;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).appBarTheme.color;
    return BlocProvider(
      create: (context) =>
          GroupSelectionCubit(selectedUsers, context.read(), context.read()),
      child: BlocConsumer<GroupSelectionCubit, GroupSelectionState>(
          listener: (context, snapshot) {
        if (snapshot.channel != null) {
          pushAndReplaceToPage(
              context,
              Scaffold(
                body: StreamChannel(
                  channel: snapshot.channel,
                  child: ChannelPage(),
                ),
              ));
        }
      }, builder: (context, snapshot) {

        return LoadingView(
          isLoading: snapshot.isLoading,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.arrow_right_alt_rounded),
                onPressed: () {
                  print('Creando grupo');
                  context.read<GroupSelectionCubit>().createGroup();
                }),
            backgroundColor: Theme.of(context).canvasColor,
            appBar: AppBar(
              title: Text(
                'New Group',
                style: TextStyle(
                    fontSize: 24, color: textColor, fontWeight: FontWeight.w800),
              ),
              centerTitle: false,
              elevation: 0,
              backgroundColor: Theme.of(context).canvasColor,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AvatarImageView(
                    //TODO: implement change avatar
                    onTap: () {
                      context.read<GroupSelectionCubit>().pickImage();
                    },
                    child: snapshot?.file != null
                        ? Image.file(snapshot.file, height: 150)
                        : Icon(Icons.person_outline,
                            size: 100, color: Colors.grey[400]),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    child: TextField(
                        controller:
                            context.read<GroupSelectionCubit>().nameTextController,
                        decoration: InputDecoration(
                            fillColor: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor,
                            hintText: 'Type group name',
                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.grey[400]),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none)),
                  ),
                  Wrap(
                    children: List.generate(selectedUsers.length, (index) {
                      final chatUserState = selectedUsers[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(chatUserState
                                          .chatUser.image !=
                                      null
                                  ? chatUserState.chatUser.image
                                  : 'https://media.istockphoto.com/vectors/no-image-available-sign-vector-id922962354?k=6&m=922962354&s=612x612&w=0&h=_KKNzEwxMkutv-DtQ4f54yA5nc39Ojb_KPvoV__aHyU='),
                            ),
                            Text(chatUserState.chatUser.name)
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
