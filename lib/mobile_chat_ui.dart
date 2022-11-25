library mobile_chat_ui;

import 'package:flutter/material.dart';
import 'package:mobile_chat_ui/custom_widgets/chat_input.dart';

import 'models/chat_theme.dart';
import 'models/messages/message.dart';
import 'models/user.dart';

// ignore: must_be_immutable
class Chat extends StatefulWidget {
  Chat(
      {Key? key,
      required this.user,
      required this.theme,
      required this.messages,
      this.showUserAvatar = false,
      this.showUsername = true,
      this.showMessageStatus = false,
      this.hasInput = true,
      this.input})
      : super(key: key);

  final ChatTheme theme;
  List<Message> messages;
  final bool showUserAvatar;
  final bool showUsername;
  final bool showMessageStatus;
  final User user;
  final bool hasInput;
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
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: widget.theme.bodyPadding,
            decoration: BoxDecoration(
              color: widget.theme.backgroundColor,
              image: widget.theme.backgroundImage,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: widget.messages
                    .map((e) => e.builder(
                        context,
                        widget.showUserAvatar,
                        widget.showMessageStatus,
                        widget.showUsername,
                        widget.user,
                        widget.theme))
                    .toList(),
              ),
            ),
          ),
        ),
        widget.hasInput
            ? widget.input ??
                ChatInput(
                  user: widget.user,
                  onSend: (message) {
                    setState(() {
                      widget.messages.add(message);
                    });
                  },
                )
            : SizedBox(),
      ],
    );
  }
}
