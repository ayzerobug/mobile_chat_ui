import 'package:flutter/material.dart';

import '../../../../utils/author_details_location.dart';
import '../../../../utils/themes/chat_theme.dart';
import '../../user.dart';
import 'message.dart';

class ActionMessage extends Message {
  final String text;
  ActionMessage({
    required super.author,
    required super.id,
    required super.time,
    required this.text,
    super.theme,
  });

  @override
  Widget builder(
      BuildContext ctx,
      bool showUserAvatar,
      bool showMessageStatus,
      bool showUsername,
      User loggedInUser,
      ChatTheme chatTheme,
      AuthorDetailsLocation authorDetailsLocation) {
    return Padding(
      padding: theme?.margin ??
          chatTheme.actionMessageTheme?.margin ??
          EdgeInsets.zero,
      child: Text(
        text,
        style: theme?.contentTextStyle ??
            chatTheme.actionMessageTheme?.contentTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
