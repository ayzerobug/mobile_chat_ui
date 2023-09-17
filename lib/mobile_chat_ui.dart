library mobile_chat_ui;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_chat_ui/custom_widgets/chat_input.dart';

import 'emptyWidget.dart';
import 'models/chat_theme.dart';
import 'models/messages/message.dart';
import 'models/messages/types.dart';
import 'models/user.dart';

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
      this.onSend,
      this.onImageSelected})
      : super(key: key);

  final ChatTheme theme;
  final List<Message> messages;
  final bool showUserAvatar;
  final bool showUsername;
  final bool showMessageStatus;
  final User user;
  final bool hasInput;
  final Widget? input;
  final Widget emptyWidget;
  final void Function(TextMessage message)? onSend;
  final void Function(ImageMessage message, XFile image)? onImageSelected;

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

  void addImageMessage(ImageMessage message, XFile image) {
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
            decoration: BoxDecoration(
              color: widget.theme.backgroundColor,
              image: widget.theme.backgroundImage,
            ),
            child: Column(
              children: [
                Expanded(
                  child: widget.messages.isNotEmpty
                      ? Padding(
                          padding: widget.theme.bodyPadding,
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
                        )
                      : widget.emptyWidget,
                ),
                if (widget.hasInput)
                  widget.input ??
                      ChatInput(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        user: widget.user,
                        onSend: widget.onSend ?? addMessage,
                        onFileSelected:
                            widget.onImageSelected ?? addImageMessage,
                      )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
