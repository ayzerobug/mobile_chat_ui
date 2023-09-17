library mobile_chat_ui;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'utils/author_details_location.dart';
import 'utils/chat_theme.dart';
import 'utils/message.dart';
import 'src/models/user.dart';
import 'utils/chat_input.dart';
import 'utils/empty_widget.dart';

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
      this.inputWidget,
      this.emptyWidget = const EmptyWidget(),
      this.authorDetailsLocation = AuthorDetailsLocation.bottom,
      this.onSend,
      this.onImageSelected})
      : super(key: key);

  /// The theme configuration for the chat interface
  final ChatTheme theme;

  /// The list of messages to be displayed in the chat interface
  final List<Message> messages;

  /// Flag to determine whether to show user avatars in messages
  final bool showUserAvatar;

  /// Flag to determine whether to show usernames with messages
  final bool showUsername;

  /// Flag to determine whether to show message status (e.g., sent, delivered) with messages
  final bool showMessageStatus;

  /// The user associated with this chat interface
  final User user;

  /// Flag to indicate whether the chat interface should include an input field for typing messages.
  final bool hasInput;

  /// The widget representing the input field for typing messages (if provided)
  final Widget? inputWidget;

  /// The widget to be displayed when there are no messages in the chat
  final Widget emptyWidget;

  /// Callback function to fire when the send icon is clicked for text messages
  final void Function(TextMessage message)? onSend;

  /// Callback function to fire when an image file is selected for sending
  final void Function(ImageMessage message, XFile image)? onImageSelected;

  /// Determine the location of a authors details;
  final AuthorDetailsLocation authorDetailsLocation;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ScrollController scrollController = ScrollController();

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
    addMessage(message);
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.theme.backgroundColor,
        image: widget.theme.backgroundImage,
      ),
      child: Column(
        children: [
          Expanded(
            child: widget.messages.isNotEmpty
                ? _buildMessagesWidget()
                : widget.emptyWidget,
          ),
          if (widget.hasInput) _buildInputWidget(),
        ],
      ),
    );
  }

  Widget _buildMessagesWidget() {
    return Padding(
      padding: widget.theme.bodyPadding,
      child: ListView.builder(
        controller: scrollController,
        itemCount: widget.messages.length,
        itemBuilder: (BuildContext context, index) => widget.messages[index]
            .builder(
                context,
                widget.showUserAvatar,
                widget.showMessageStatus,
                widget.showUsername,
                widget.user,
                widget.theme,
                widget.authorDetailsLocation),
      ),
    );
  }

  Widget _buildInputWidget() {
    return widget.inputWidget ??
        ChatInput(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          user: widget.user,
          onSend: (TextMessage message) {
            widget.onSend != null
                ? widget.onSend!(message)
                : addMessage(message);
            scrollToBottom();
          },
          onFileSelected: (ImageMessage message, XFile file) {
            widget.onImageSelected != null
                ? widget.onImageSelected!(message, file)
                : addMessage(message);
            scrollToBottom();
          },
        );
  }
}
