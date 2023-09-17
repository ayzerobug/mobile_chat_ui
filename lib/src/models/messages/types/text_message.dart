import 'package:flutter/material.dart';

import '../../../widgets/containers/message_container.dart';
import '../../../widgets/containers/text_container.dart';
import '../../../../utils/author_details_location.dart';
import '../../../../utils/chat_theme.dart';
import '../../user.dart';
import 'message.dart';

class TextMessage extends Message {
  final String text;
  TextMessage(
      {required super.author,
      required super.time,
      super.stage = 0,
      required this.text});

  @override
  Widget builder(
      BuildContext ctx,
      bool showUserAvatar,
      bool showMessageStatus,
      bool showUsername,
      User loggedInUser,
      ChatTheme theme,
      AuthorDetailsLocation authorDetailsLocation) {
    return MessageContainer(
      parentContext: ctx,
      message: this,
      theme: theme,
      showUserAvatar: showUserAvatar,
      showMessageStatus: showMessageStatus,
      showUsername: showUsername,
      user: loggedInUser,
      detailsLocation: authorDetailsLocation,
      child: Padding(
        padding: theme.messagePadding,
        child: TextContainer(
          text: text,
          style: author.id == loggedInUser.id
              ? theme.outwardMessageTextStyle
              : theme.inwardMessageTextStyle,
          linkStyle: theme.urlTextStyle,
        ),
      ),
    );
  }
}
