import 'package:flutter/material.dart';

import '../../models/chat_theme.dart';
import '../user.dart';

abstract class Message {
  User? author;
  String? time;
  int? stage;

  Message({this.author, this.time = "now", this.stage});

  Widget builder(BuildContext ctx, bool showUserAvatar, bool showMessageStatus,
      bool showUsername,
      User loggedInUser, ChatTheme theme);
}
