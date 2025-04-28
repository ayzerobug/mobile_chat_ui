import 'package:flutter/material.dart';
import 'package:mobile_chat_ui/src/widgets/containers/outward_message_container.dart';
import 'package:mobile_chat_ui/utils/author_details_location.dart';

import '../../../utils/themes/chat_theme.dart';
import '../../models/user.dart';
import 'inward_message_container.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({
    Key? key,
    required this.parentContext,
    required this.message,
    required this.chatTheme,
    required this.showUserAvatar,
    required this.showMessageStatus,
    required this.showUsername,
    required this.child,
    required this.user,
    required this.detailsLocation,
  }) : super(key: key);
  final BuildContext parentContext;
  final dynamic message;
  final Widget child;
  final ChatTheme chatTheme;
  final bool showUsername;
  final bool showUserAvatar;
  final bool showMessageStatus;
  final User user;
  final AuthorDetailsLocation detailsLocation;
  @override
  Widget build(BuildContext context) {
    return message.author.id == user.id
        ? outwardMessageContainer(
            ctx: parentContext,
            time: message.time!,
            stage: message.stage!,
            messageTheme: message.theme,
            child: child,
            chatTheme: chatTheme,
            showName: showUsername,
            showMessageStatus: showMessageStatus,
            showAvatar: showUserAvatar,
            user: message.author,
            detailsLocation: detailsLocation)
        : inwardMessageContainer(
            ctx: parentContext,
            time: message.time!,
            user: message.author,
            messageTheme: message.theme,
            verificationBadge: chatTheme.verificationBadge,
            child: child,
            showName: showUsername,
            showAvatar: showUserAvatar,
            detailsLocation: detailsLocation,
            chatTheme: chatTheme,
          );
  }
}
