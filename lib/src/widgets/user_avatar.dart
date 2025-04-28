import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/themes/chat_theme.dart';
import '../models/user.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key? key, required this.user, required this.chatTheme})
      : super(key: key);
  final User user;
  final ChatTheme chatTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CircleAvatar(
        backgroundColor: user.color ?? chatTheme.defaultUserColor,
        radius: chatTheme.userAvatarRadius,
        backgroundImage: user.avatarUrl != null
            ? CachedNetworkImageProvider(user.avatarUrl!)
            : null,
        child: user.avatarUrl == null
            ? Text(
                user.name![0],
                style: chatTheme.avatarTextStyle
                    .copyWith(fontSize: chatTheme.userAvatarRadius * 1.2),
              )
            : null,
      ),
    );
  }
}
