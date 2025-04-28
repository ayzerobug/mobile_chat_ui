import 'package:flutter/material.dart';
import 'package:mobile_chat_ui/utils/themes/message_theme.dart';

import '../../../../utils/themes/chat_theme.dart';
import '../../../../utils/author_details_location.dart';
import '../../user.dart';

abstract class Message {
  User author;
  String? time;
  int? stage;
  final String id;
  final MessageTheme? theme;

  Message(
      {required this.author,
      this.time = "now",
      this.stage = 0,
      required this.id,
      this.theme});

  Widget builder(
      BuildContext ctx,
      bool showUserAvatar,
      bool showMessageStatus,
      bool showUsername,
      User loggedInUser,
      ChatTheme chatTheme,
      AuthorDetailsLocation authorDetailsLocation);
}
