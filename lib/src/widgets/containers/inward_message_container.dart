import 'dart:math';

import 'package:flutter/material.dart';

import '../../../utils/chat_theme.dart';
import '../../models/user.dart';
import '../../../utils/author_details_location.dart';
import '../user_avatar.dart';

Widget inwardMessageContainer({
  required BuildContext ctx,
  required ChatTheme theme,
  required String time,
  required Widget child,
  required bool showName,
  required bool showAvatar,
  required Widget verificationBadge,
  required User user,
  required AuthorDetailsLocation detailsLocation,
}) {
  final maxMessageWidth = min(
    max((MediaQuery.of(ctx).size.width - theme.messageMargin.horizontal), 350),
    MediaQuery.of(ctx).size.width * (theme.messageWidth),
  );

  return Row(
    children: [
      Padding(
        padding: theme.messageMargin,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxMessageWidth.toDouble()),
          child: _ChatMessage(
            ctx: ctx,
            theme: theme,
            child: child,
            time: time,
            user: user,
            showName: showName,
            showAvatar: showAvatar,
            verificationBadge: verificationBadge,
            detailsLocation: detailsLocation,
          ),
        ),
      ),
      const Spacer(),
    ],
  );
}

class _ChatMessage extends StatelessWidget {
  const _ChatMessage(
      {required this.ctx,
      required this.theme,
      required this.child,
      required this.time,
      required this.user,
      required this.showName,
      required this.showAvatar,
      required this.verificationBadge,
      required this.detailsLocation});
  final BuildContext ctx;
  final ChatTheme theme;
  final Widget child;
  final String time;
  final User user;
  final bool showName;
  final bool showAvatar;
  final Widget verificationBadge;
  final AuthorDetailsLocation detailsLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (detailsLocation == AuthorDetailsLocation.top)
          Column(children: [_authorsDetails(), const SizedBox(height: 5)]),
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.inwardMessageBackgroundColor,
            borderRadius: theme.inwardMessageBorderRadius,
          ),
          child: IntrinsicWidth(child: child),
        ),
        if (detailsLocation == AuthorDetailsLocation.bottom)
          Column(children: [const SizedBox(height: 5), _authorsDetails()]),
      ],
    );
  }

  Widget _authorsDetails() {
    return Row(
      children: [
        if (showAvatar) UserAvatar(user: user, theme: theme),
        if (showName)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.name ?? "",
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: theme.usernameTextStyle.copyWith(color: user.color),
              ),
              const SizedBox(width: 5),
              if (user.isVerified) theme.verificationBadge else Container(),
            ],
          ),
        const SizedBox(width: 10),
        Text(
          time,
          style: theme.timeTextStyle,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
