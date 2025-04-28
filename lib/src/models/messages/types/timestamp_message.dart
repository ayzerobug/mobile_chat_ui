import 'package:flutter/material.dart';

import '../../../../utils/author_details_location.dart';
import '../../../../utils/themes/chat_theme.dart';
import '../../user.dart';
import 'message.dart';

class TimeStampMessage extends Message {
  final String displayTime;
  TimeStampMessage(
      {required super.author, required super.id, required this.displayTime});

  @override
  Widget builder(
      BuildContext ctx,
      bool showUserAvatar,
      bool showMessageStatus,
      bool showUsername,
      User loggedInUser,
      ChatTheme theme,
      AuthorDetailsLocation authorDetailsLocation) {
    return Text(
      displayTime,
      style: theme.timestampTextStyle,
      textAlign: TextAlign.center,
    );
  }
}
