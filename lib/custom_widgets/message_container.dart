import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_chat_ui/custom_widgets/status_builder.dart';
import 'package:mobile_chat_ui/modals/chat_theme.dart';
import 'package:mobile_chat_ui/modals/messages/message.dart';

import '../modals/user.dart';
import 'user_avatar.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({
    Key? key,
    required this.parentContext,
    required this.message,
    required this.theme,
    required this.showUserAvatar,
    required this.showUsername,
    required this.child,
    required this.user,
  }) : super(key: key);
  final BuildContext parentContext;
  final dynamic message;
  final Widget child;
  final ChatTheme theme;
  final bool showUsername;
  final bool showUserAvatar;
  final User user;
  @override
  Widget build(BuildContext context) {
    return message.author == user
        ? loggedInUserBoilerPlate(
            ctx: parentContext,
            time: message.time!,
            stage: message.stage!,
            child: child,
            theme: theme,
            showName: showUsername,
            showAvatar: showUserAvatar,
            user: message.author!,
          )
        : chatClientBoilerPlate(
            ctx: parentContext,
            time: message.time!,
            user: message.author!,
            verificationBadge: theme.verificationBadge,
            child: child,
            showName: showUsername,
            showAvatar: showUserAvatar,
            theme: theme,
          );
  }
}

Widget loggedInUserBoilerPlate({
  required BuildContext ctx,
  required ChatTheme theme,
  required String time,
  required int stage,
  required Widget child,
  required bool showAvatar,
  required bool showName,
  required User user,
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
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: theme.outwardMessageBackgroundColor,
                    borderRadius: theme.outwardMessageBorderRadius,
                  ),
                  child: IntrinsicWidth(child: child),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    buildMessageStatus(stage, theme),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      time,
                      style: theme.timeTextStyle,
                      textAlign: TextAlign.end,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    showName
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "You",
                                style: theme.usernameTextStyle
                                    .copyWith(color: user.color),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              user.isVerified
                                  ? theme.verificationBadge
                                  : Container(),
                            ],
                          )
                        : Container(),
                    showAvatar
                        ? UserAvatar(user: user, theme: theme)
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget chatClientBoilerPlate(
    {required BuildContext ctx,
    required ChatTheme theme,
    required String time,
    required Widget child,
    required bool showName,
    required bool showAvatar,
    required Widget verificationBadge,
    required User user}) {
  return Row(
    children: [
      Padding(
        padding: theme.messageMargin,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: min(
              max(
                  (MediaQuery.of(ctx).size.width -
                      theme.messageMargin.horizontal),
                  350),
              MediaQuery.of(ctx).size.width * (theme.messageWidth),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.inwardMessageBackgroundColor,
                  borderRadius: theme.inwardMessageBorderRadius,
                ),
                child: IntrinsicWidth(child: child),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      showAvatar
                          ? UserAvatar(
                              user: user,
                              theme: theme,
                            )
                          : Container(),
                      showName
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user.name ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  style: theme.usernameTextStyle
                                      .copyWith(color: user.color),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                user.isVerified
                                    ? theme.verificationBadge
                                    : Container(),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    time,
                    style: theme.timeTextStyle,
                    textAlign: TextAlign.end,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      const Spacer(),
    ],
  );
}
