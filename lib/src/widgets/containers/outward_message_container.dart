import 'package:flutter/material.dart';

import '../../../utils/chat_theme.dart';
import '../../models/user.dart';
import '../../../utils/author_details_location.dart';
import '../status_builder.dart';
import '../user_avatar.dart';

Widget outwardMessageContainer({
  required BuildContext ctx,
  required ChatTheme theme,
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
    padding: theme.messageMargin,
    child: Row(
      children: [
        const Spacer(),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(ctx).size.width * (theme.messageWidth),
          ),
          child: _ChatMessage(
            ctx: ctx,
            theme: theme,
            child: child,
            time: time,
            user: user,
            stage: stage,
            showName: showName,
            showAvatar: showAvatar,
            detailsLocation: detailsLocation,
            showMessageStatus: showMessageStatus,
          ),
        ),
      ],
    ),
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
      required this.detailsLocation,
      required this.showMessageStatus,
      required this.stage});
  final BuildContext ctx;
  final ChatTheme theme;
  final Widget child;
  final String time;
  final User user;
  final bool showName;
  final bool showAvatar;
  final bool showMessageStatus;
  final int stage;
  final AuthorDetailsLocation detailsLocation;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (detailsLocation == AuthorDetailsLocation.top)
            Column(children: [_authorDetails(), const SizedBox(height: 5)]),
          Container(
            decoration: BoxDecoration(
              color: theme.outwardMessageBackgroundColor,
              borderRadius: theme.outwardMessageBorderRadius,
            ),
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
                  buildMessageStatus(stage, theme),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              )
            : SizedBox(),
        Text(
          time,
          style: theme.timeTextStyle,
          textAlign: TextAlign.end,
        ),
        showName
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "You",
                    style: theme.usernameTextStyle.copyWith(color: user.color),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  user.isVerified ? theme.verificationBadge : Container(),
                ],
              )
            : Container(),
        !showName && showAvatar
            ? Container()
            : const SizedBox(
                width: 20,
              ),
        showAvatar ? UserAvatar(user: user, theme: theme) : Container(),
      ],
    );
  }
}
