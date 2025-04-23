import 'package:flutter/material.dart';

import '../../../widgets/containers/message_container.dart';
import '../../../widgets/containers/text_container.dart';
import '../../../../utils/author_details_location.dart';
import '../../../../utils/themes/chat_theme.dart';
import '../../user.dart';
import 'message.dart';

class TextMessage extends Message {
  final String text;
  TextMessage(
      {required super.author,
      required super.time,
      super.stage = 0,
      required super.id,
      super.theme,
      required this.text});

  @override
  Widget builder(
      BuildContext ctx,
      bool showUserAvatar,
      bool showMessageStatus,
      bool showUsername,
      User loggedInUser,
      ChatTheme chatTheme,
      AuthorDetailsLocation authorDetailsLocation) {
    final messageTheme = author.id == loggedInUser.id
        ? chatTheme.outwardMessageTheme
        : chatTheme.inwardMessageTheme;

    return MessageContainer(
      parentContext: ctx,
      message: this,
      chatTheme: chatTheme,
      showUserAvatar: showUserAvatar,
      showMessageStatus: showMessageStatus,
      showUsername: showUsername,
      user: loggedInUser,
      detailsLocation: authorDetailsLocation,
      child: Padding(
        padding: theme?.padding ?? messageTheme?.padding ?? EdgeInsets.zero,
        child: TextContainer(
          textStyle: theme?.contentTextStyle ?? messageTheme?.contentTextStyle,
          text: text,
          linkTextStyle: theme?.urlTextStyle ?? messageTheme?.urlTextStyle,
          boldTextStyle: theme?.boldTextStyle ?? messageTheme?.boldTextStyle,
        ),
      ),
    );
  }
}
