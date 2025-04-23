import 'package:flutter/material.dart';
import 'package:mobile_chat_ui/utils/themes/message_theme.dart';

import '../../../utils/themes/chat_theme.dart';
import '../../models/user.dart';
import '../../../utils/author_details_location.dart';
import '../status_builder.dart';
import '../user_avatar.dart';

Widget outwardMessageContainer({
  required BuildContext ctx,
  required ChatTheme chatTheme,
  required MessageTheme? messageTheme,
  required String time,
  required int stage,
  required Widget child,
  required bool showAvatar,
  required bool showMessageStatus,
  required bool showName,
  required User user,
  required AuthorDetailsLocation detailsLocation,
}) {
  return Padding(
    padding: messageTheme?.margin ??
        chatTheme.outwardMessageTheme?.margin ??
        EdgeInsets.zero,
    child: Row(
      children: [
        const Spacer(),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(ctx).size.width *
                (messageTheme?.messageWidth ??
                    chatTheme.outwardMessageTheme?.messageWidth ??
                    0.7),
          ),
          child: _ChatMessage(
            ctx: ctx,
            chatTheme: chatTheme,
            child: child,
            time: time,
            user: user,
            stage: stage,
            showName: showName,
            showAvatar: showAvatar,
            detailsLocation: detailsLocation,
            showMessageStatus: showMessageStatus,
            decoration: BoxDecoration(
              border:
                  messageTheme?.border ?? chatTheme.outwardMessageTheme?.border,
              color: messageTheme?.backgroundColor ??
                  chatTheme.outwardMessageTheme?.backgroundColor,
              borderRadius: messageTheme?.borderRadius ??
                  chatTheme.outwardMessageTheme?.borderRadius,
            ),
          ),
        ),
      ],
    ),
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
    required this.detailsLocation,
    required this.showMessageStatus,
    required this.stage,
    this.decoration,
  });
  final BuildContext ctx;
  final ChatTheme chatTheme;
  final Widget child;
  final String time;
  final User user;
  final bool showName;
  final bool showAvatar;
  final bool showMessageStatus;
  final int stage;
  final AuthorDetailsLocation detailsLocation;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (detailsLocation == AuthorDetailsLocation.top)
            Column(children: [_authorDetails(), const SizedBox(height: 5)]),
          Container(
            decoration: decoration,
            child: IntrinsicWidth(child: child),
          ),
          if (detailsLocation == AuthorDetailsLocation.bottom)
            Column(children: [const SizedBox(height: 5), _authorDetails()]),
        ],
      ),
    );
  }

  Widget _authorDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        showMessageStatus
            ? Row(
                children: [
                  buildMessageStatus(stage, chatTheme),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              )
            : SizedBox(),
        Text(
          time,
          style: chatTheme.timeTextStyle,
          textAlign: TextAlign.end,
        ),
        Spacer(),
        SizedBox(width: MediaQuery.of(ctx).size.height * 0.01),
        showName
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You",
                    style:
                        chatTheme.usernameTextStyle.copyWith(color: user.color),
                  ),
                  if (user.isVerified)
                    const SizedBox(
                      width: 5,
                    ),
                  user.isVerified ? chatTheme.verificationBadge : Container(),
                ],
              )
            : Container(),
        !showName && showAvatar
            ? Container()
            : const SizedBox(
                width: 10,
              ),
        showAvatar ? UserAvatar(user: user, chatTheme: chatTheme) : Container(),
      ],
    );
  }
}
