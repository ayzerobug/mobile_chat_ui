library mobile_chat_ui;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_chat_ui/custom_widgets/chat_input.dart';

import 'emptyWidget.dart';
import 'models/chat_theme.dart';
import 'models/messages/message.dart';
import 'models/messages/types.dart';
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
      this.input,
      this.emptyWidget = const EmptyWidget(),
      this.onSend})
      : super(key: key);

  final ChatTheme theme;
  List<Message> messages;
  final bool showUserAvatar;
  final bool showUsername;
  final bool showMessageStatus;
  final User user;
  final bool hasInput;
  final Widget? input;
  final Widget emptyWidget;
  void Function(Message message)? onSend;
  void Function()? onAttachBtnClicked;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  void initState() {
    super.initState();
  }

  void addMessage(Message message) {
    setState(() {
      widget.messages.add(message);
    });
  }

  void attachBtn() async {
    XFile? result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );
    if (result != null) {
      final message = ImageMessage(
        author: widget.user,
        time: "now",
        stage: 0,
        uri: result.path,
      );
      addMessage(message);
    }
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
            child: widget.messages.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          reverse: true,
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
                      ChatInput(
                        user: widget.user,
                        onSend: widget.onSend ?? addMessage,
                        attachBtnClicked:
                            widget.onAttachBtnClicked ?? attachBtn,
                      )
                    ],
                  )
                : widget.emptyWidget,
          ),
        ),
      ],
    );
  }
}
