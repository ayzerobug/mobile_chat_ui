import 'dart:math';

import 'package:flutter/material.dart';

import '../../../utils/themes/chat_theme.dart';
import '../../../utils/themes/message_theme.dart';
import '../../models/user.dart';
import '../../../utils/author_details_location.dart';
import '../user_avatar.dart';

Widget inwardMessageContainer({
  required BuildContext ctx,
  required ChatTheme chatTheme,
  required MessageTheme? messageTheme,
  required String time,
  required Widget child,
  required bool showName,
  required bool showAvatar,
  required Widget verificationBadge,
  required User user,
  required AuthorDetailsLocation detailsLocation,
}) {
  final maxMessageWidth = min(
    max(
        (MediaQuery.of(ctx).size.width -
            (messageTheme?.margin ??
                    chatTheme.inwardMessageTheme?.margin ??
                    EdgeInsets.zero)
                .horizontal),
        350),
    MediaQuery.of(ctx).size.width *
        (messageTheme?.messageWidth ??
            chatTheme.inwardMessageTheme?.messageWidth ??
            0.7),
  );

  return Row(
    children: [
      Padding(
        padding: messageTheme?.margin ??
            chatTheme.inwardMessageTheme?.margin ??
            EdgeInsets.zero,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxMessageWidth.toDouble()),
          child: _ChatMessage(
            ctx: ctx,
            chatTheme: chatTheme,
            child: child,
            time: time,
            user: user,
            showName: showName,
            showAvatar: showAvatar,
            verificationBadge: verificationBadge,
            detailsLocation: detailsLocation,
            decoration: BoxDecoration(
              border:
                  messageTheme?.border ?? chatTheme.inwardMessageTheme?.border,
              color: messageTheme?.backgroundColor ??
                  chatTheme.inwardMessageTheme?.backgroundColor,
              borderRadius: messageTheme?.borderRadius ??
                  chatTheme.inwardMessageTheme?.borderRadius,
            ),
          ),
        ),
      ),
      const Spacer(),
    ],
  );
}

class _ChatMessage extends StatelessWidget {
  const _ChatMessage({
    required this.ctx,
    required this.chatTheme,
    required this.child,
    required this.time,
    required this.user,
    required this.showName,
    required this.showAvatar,
    required this.verificationBadge,
    required this.detailsLocation,
    this.decoration,
  });
  final BuildContext ctx;
  final ChatTheme chatTheme;
  final Widget child;
  final String time;
  final User user;
  final bool showName;
  final bool showAvatar;
  final Widget verificationBadge;
  final AuthorDetailsLocation detailsLocation;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (detailsLocation == AuthorDetailsLocation.top)
          Column(
              children: [_authorsDetails(context), const SizedBox(height: 5)]),
        Container(
          decoration: decoration,
          child: IntrinsicWidth(child: child),
        ),
        if (detailsLocation == AuthorDetailsLocation.bottom)
          Column(
              children: [const SizedBox(height: 5), _authorsDetails(context)]),
      ],
    );
  }

  Widget _authorsDetails(BuildContext context) {
    return Row(
      children: [
        if (showAvatar) UserAvatar(user: user, chatTheme: chatTheme),
        if (showName)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.name ?? "",
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: chatTheme.usernameTextStyle.copyWith(color: user.color),
              ),
              const SizedBox(width: 5),
              if (user.isVerified) chatTheme.verificationBadge else Container(),
            ],
          ),
        Spacer(),
        SizedBox(width: MediaQuery.of(context).size.height * 0.01),
        Text(
          time,
          style: chatTheme.timeTextStyle,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
