library mobile_chat_ui;

import 'package:flutter/material.dart';

import 'modals/chat_theme.dart';
import 'modals/messages/message.dart';
import 'modals/user.dart';

class Chat extends StatefulWidget {
  const Chat(
      {Key? key,
      required this.user,
      required this.theme,
      required this.messages,
      this.showUserAvatar = false,
      this.showUsername = true,
      required this.input})
      : super(key: key);

  final ChatTheme theme;
  final List<Message> messages;
  final bool showUserAvatar;
  final bool showUsername;
  final User user;
  final Widget? input;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.theme.bodyPadding,
      decoration: BoxDecoration(
        color: widget.theme.backgroundColor,
        image: widget.theme.backgroundImage,
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: widget.messages
                    .map((e) => e.builder(context, widget.showUserAvatar,
                        widget.showUsername, widget.user, widget.theme))
                    .toList(),
              ),
            ),
          ),
          widget.input ?? Container()
        ],
      ),
    );
  }
}
