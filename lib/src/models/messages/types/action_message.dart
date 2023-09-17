import 'package:flutter/material.dart';

import '../../../../utils/author_details_location.dart';
import '../../../../utils/chat_theme.dart';
import '../../user.dart';
import 'message.dart';

class ActionMessage extends Message {
  final String text;
  ActionMessage(
      {required super.author, required super.time, required this.text});

  @override
  Widget builder(
      BuildContext ctx,
      bool showUserAvatar,
      bool showMessageStatus,
      bool showUsername,
      User loggedInUser,
      ChatTheme theme,
      AuthorDetailsLocation authorDetailsLocation) {
    return Padding(
      padding: theme.actionMessageMargin,
      child: Text(
        text,
        style: theme.actionMessageTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
