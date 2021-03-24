import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).appBarTheme.color;
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          'Chats',
          style: TextStyle(
              fontSize: 24, color: textColor, fontWeight: FontWeight.w900),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: ChannelsBloc(
        child: ChannelListView(
          filter: {
            'members': {
              '\$in': [StreamChat.of(context).user?.id]
            }
          },
          sort: [SortOption('last_message_at')],
          onImageTap: (channel) {
            String name;
            String image;
            final currentUser = StreamChat.of(context).client.state.user;
            if (channel.isGroup) {
              name = channel.extraData['name'];
              image = channel.extraData['image'];
            } else {
              final friend = channel.state.members
                  .where((element) => element.userId != currentUser.id)
                  .first
                  .user;
              name = friend.name;
              image = friend.extraData['image'];
            }

            Navigator.of(context).push(PageRouteBuilder(
                barrierColor: Colors.black45,
                barrierDismissible: true,
                opaque: false,
                pageBuilder: (context, animation1, _) {
                  return FadeTransition(
                      opacity: animation1,
                      child: ChannelDetailView(
                        image: image ?? '',
                        name: name ?? '',
                        channelId: channel.id,
                      ));
                }));
          },
          /*channelPreviewBuilder: (context, channel) {
            return MyChannelPreview(
              channel: channel,
              heroTag: channel.id,
              onImageTap: () {
                
              },
              onTap: (channel) =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return StreamChannel(child: ChannelPage(), channel: channel);
              })),
            );
          },*/
          channelWidget: ChannelPage(),
        ),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(),
      body: Column(
        children: [Expanded(child: MessageListView()), MessageInput()],
      ),
    );
  }
}

class ChannelDetailView extends StatelessWidget {
  const ChannelDetailView({Key key, this.image, this.name, this.channelId})
      : super(key: key);

  final String image;
  final String name;
  final String channelId;

  @override
  Widget build(BuildContext context) {
    print('name: $name -- image $image');
    return GestureDetector(
      onTap: Navigator.of(context).pop,
      child: Material(
        color: Colors.transparent,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                    tag: channelId,
                    child: ClipOval(
                        child: Image.network(
                      image ?? 'https://thumbs.dreamstime.com/b/no-image-available-icon-photo-camera-flat-vector-illustration-132483141.jpg',
                      height: 180,
                      width: 180,
                      fit: BoxFit.cover,
                    ))),
                Text(
                  name ?? '',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
