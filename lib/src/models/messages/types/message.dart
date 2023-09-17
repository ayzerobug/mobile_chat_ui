import 'package:flutter/material.dart';

import '../../../../utils/chat_theme.dart';
import '../../../../utils/author_details_location.dart';
import '../../user.dart';

abstract class Message {
  User author;
  String? time;
  int? stage;

  Message({required this.author, this.time = "now", this.stage});

  Widget builder(
      BuildContext ctx,
      bool showUserAvatar,
      bool showMessageStatus,
      bool showUsername,
      User loggedInUser,
      ChatTheme theme,
      AuthorDetailsLocation authorDetailsLocation);
}
