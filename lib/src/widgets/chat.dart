import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../utils/author_details_location.dart';
import '../../utils/chat_input.dart';
import '../../utils/empty_widget.dart';
import '../../utils/message.dart';
import '../../utils/themes/chat_theme.dart';
import '../../utils/user.dart';

class Chat extends StatefulWidget {
  Chat({
    Key? key,
    required this.user,
    required this.chatTheme,
    required this.messages,
    this.showUserAvatar = false,
    this.showUsername = true,
    this.showMessageStatus = false,
    this.hasInput = true,
    this.inputWidget,
    this.emptyWidget = const EmptyWidget(),
    this.authorDetailsLocation = AuthorDetailsLocation.bottom,
    this.onSend,
    this.onImageSelected,
    this.onLoadMore,
    this.promptWidget,
    this.onMessageVisibleOnScreen,
  }) : super(key: key);

  /// The theme configuration for the chat interface
  final ChatTheme chatTheme;

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
  final void Function(Message message)? onSend;

  /// Callback function to fire when an image file is selected for sending
  final void Function(ImageMessage message, XFile image)? onImageSelected;

  /// Determine the location of a authors details;
  final AuthorDetailsLocation authorDetailsLocation;

  /// These are inchat actions a user can perform. If none are provided, then this is not shown
  final Widget? promptWidget;

  /// Callback function to fire to trigger loading more messages
  final Future<void> Function()? onLoadMore;

  /// Callback function to fire when a message is visible on screen
  final void Function(Message message)? onMessageVisibleOnScreen;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ScrollController scrollController = ScrollController();
  int _prevMessageCount = 0;
  final double _autoScrollThreshold = 100.0;

  void addMessage(Message message) {
    setState(() {
      widget.messages.insert(0, message);
    });
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _onScroll() {
    if (scrollController.position.pixels <= 50) {
      widget.onLoadMore?.call();
    }
  }

  @override
  void initState() {
    super.initState();
    _prevMessageCount = widget.messages.length;
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
    scrollController.addListener(_onScroll);
  }

  bool get _isNearBottom {
    if (!scrollController.hasClients) return false;
    final distanceFromBottom =
        scrollController.position.maxScrollExtent - scrollController.offset;
    return distanceFromBottom < _autoScrollThreshold;
  }

  @override
  void didUpdateWidget(covariant Chat oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newMessageCount = widget.messages.length;
    if (newMessageCount > _prevMessageCount) {
      _prevMessageCount = newMessageCount;

      // Only scroll if user is near the bottom
      if (_isNearBottom) {
        WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
      }
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.chatTheme.backgroundColor,
        image: widget.chatTheme.backgroundImage,
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
      padding: widget.chatTheme.bodyPadding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            controller: scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...widget.messages.reversed.map((message) {
                    return LayoutBuilder(
                      builder: (context, innerConstraints) {
                        return VisibilityDetector(
                          key: Key(message.id),
                          onVisibilityChanged: (info) {
                            // Mark as seen if at least 50% is visible
                            if (info.visibleFraction > 0.5 &&
                                widget.onMessageVisibleOnScreen != null) {
                              widget.onMessageVisibleOnScreen!(message);
                            }
                          },
                          child: message.builder(
                            context,
                            widget.showUserAvatar,
                            widget.showMessageStatus,
                            widget.showUsername,
                            widget.user,
                            widget.chatTheme,
                            widget.authorDetailsLocation,
                          ),
                        );
                      },
                    );
                  }).toList(),
                  if (widget.promptWidget != null) widget.promptWidget!,
                  SizedBox(height: MediaQuery.of(context).size.height * 0.020),
                  // padding above input
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputWidget() {
    return widget.inputWidget ??
        ChatInput(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          user: widget.user,
          theme: widget.chatTheme,
          onSend: (Message message) {
            widget.onSend != null
                ? widget.onSend!(message)
                : addMessage(message);
            // scrollToBottom();
          },
        );
  }
}
