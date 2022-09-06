import 'package:flutter/material.dart';
import 'package:mobile_chat_ui/modals/chat_theme.dart';

import '../user.dart';

abstract class Message {
  User? author;
  String? time;
  int? stage;

  Message({this.author, this.time, this.stage});

  Widget builder(BuildContext ctx, bool showUserAvatar, bool showUsername,
      User loggedInUser, ChatTheme theme);
}
