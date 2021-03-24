import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class MyChannelPreview extends StatelessWidget {
  const MyChannelPreview(
      {Key key,
      this.onTap,
      this.onLongPress,
      @required this.channel,
      this.onImageTap,
      this.heroTag})
      : super(key: key);

  final void Function(Channel) onTap;
  final void Function(Channel) onLongPress;
  final Channel channel;
  final VoidCallback onImageTap;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
